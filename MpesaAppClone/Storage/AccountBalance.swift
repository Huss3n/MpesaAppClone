//
//  AccountBalance.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 27/05/2024.
//

import Foundation

final class MpesaBalance: ObservableObject {
    static let instance = MpesaBalance()
    private let mpesaBalanceKey = "mpesaBALANCE"
    private let mshwariBalanceKey = "mshwariAmount"
    private let loanKey = "keyLoan"

    @Published var mpesaBalance: Double = 0 {
        didSet {
            saveMpesaBalance()
            Task {
                try await updateBalanceInFirebase()
                try await fetchMpesaBalanceFromDB()
            }
        }
    }
    
    @Published var firstName: String = ""
    
    @Published var mshwariBalance: Double = 100 {
        didSet {
            saveMshwariBalance()
        }
    }
    
    @Published var loanBalance: Double = 0 {
        didSet {
            saveLoanBalance()
        }
    }
    
    private init() {
        Task {
            try await initializeBalances()
        }
        loadBalances()
    }
    
    private func initializeBalances() async throws {
        try await fetchMpesaBalanceFromDB()
        saveMpesaBalance()
    }
    
    private func fetchMpesaBalanceFromDB() async throws {
        let user = try await DatabaseService.instance.fetchUserDetails()
        DispatchQueue.main.async {
            self.mpesaBalance = user.mpesaBalance
            self.firstName = user.firstName
        }
    }
    
    private func updateBalanceInFirebase() async throws {
        try await DatabaseService.instance.updateUserBalance(newBalance: mpesaBalance)
    }
    
    private func saveMpesaBalance() {
        if let encoded = try? JSONEncoder().encode(mpesaBalance) {
            UserDefaults.standard.set(encoded, forKey: mpesaBalanceKey)
        }
    }
    
    private func loadBalances() {
        if let data = UserDefaults.standard.data(forKey: mpesaBalanceKey),
           let decoded = try? JSONDecoder().decode(Double.self, from: data) {
            mpesaBalance = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: mshwariBalanceKey),
           let decoded = try? JSONDecoder().decode(Double.self, from: data) {
            mshwariBalance = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: loanKey),
           let decoded = try? JSONDecoder().decode(Double.self, from: data) {
            loanBalance = decoded
        }
    }
    
    private func saveMshwariBalance() {
        if let encoded = try? JSONEncoder().encode(mshwariBalance) {
            UserDefaults.standard.set(encoded, forKey: mshwariBalanceKey)
        }
    }
    
    private func saveLoanBalance() {
        if let encoded = try? JSONEncoder().encode(loanBalance) {
            UserDefaults.standard.set(encoded, forKey: loanKey)
        }
    }
    
    func deductAmount(amount: Double, transaction: Double) async {
        let total = amount + transaction
        do {
            try await DatabaseService.instance.deductUserBalance(newAmount: total)
            try await fetchMpesaBalanceFromDB()
        } catch {
            print("Error in deduction firestore amount \(error.localizedDescription)")
        }
    }
    
    func deductMpesaBalanceAddToMshwari(depositAmount: Double) async {
        do {
            try await DatabaseService.instance.deductUserBalance(newAmount: depositAmount)
            mpesaBalance -= depositAmount
            mshwariBalance += depositAmount
            saveMpesaBalance()
            saveMshwariBalance()
            try await fetchMpesaBalanceFromDB()
        } catch {
            print("Error deducting amount")
        }
    }
    
    func deductMshwariBalanceAddToMpesa(withdrawAmount: Double) async {
        do {
            try await DatabaseService.instance.addUserBalance(newAmount: withdrawAmount)
            mshwariBalance -= withdrawAmount
            mpesaBalance += withdrawAmount
            saveMpesaBalance()
            saveMshwariBalance()
            try await fetchMpesaBalanceFromDB()
        } catch {
            print("Error adding amount from mshwari")
        }
    }
    
    func addLoanAmountToMpesaBalance(loanAmount: Double) async {
        do {
            try await DatabaseService.instance.addUserBalance(newAmount: loanAmount)
            mpesaBalance += loanAmount
            loanBalance += loanAmount
            saveMpesaBalance()
            saveLoanBalance()
            try await fetchMpesaBalanceFromDB()
        } catch {
            print("Error adding loan amount to balance")
        }
    }
    
    func payLoan(amount: Double) async {
        loanBalance -= amount
        do {
            try await DatabaseService.instance.deductUserBalance(newAmount: amount)
            mpesaBalance -= amount
            saveMpesaBalance()
            saveLoanBalance()
            try await fetchMpesaBalanceFromDB()
        } catch {
            print("Error when paying loan")
        }
    }
}
