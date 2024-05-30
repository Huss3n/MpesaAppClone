//
//  AccountBalance.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 27/05/2024.
//

import Foundation
final class MpesaBalance: ObservableObject {
    static let instance = MpesaBalance()
    private let mpesaBalanceKey = "userMpesaBALANCE"
    
    @Published var mpesaBalance: Double = 5000 {
        didSet {
            saveMpesaBalance()
        }
    }
    
    private init() {
        loadMpesaBalance()
    }
    
    private func saveMpesaBalance() {
        if let encoded = try? JSONEncoder().encode(mpesaBalance) {
            UserDefaults.standard.set(encoded, forKey: mpesaBalanceKey)
        }
    }
    
    private func loadMpesaBalance() {
        if let data = UserDefaults.standard.data(forKey: mpesaBalanceKey),
           let decoded = try? JSONDecoder().decode(Double.self, from: data) {
            mpesaBalance = decoded
        }
    }
    
    func deductAmount(amount: Double, transaction: Double) {
        mpesaBalance -= amount + transaction
    }
}
