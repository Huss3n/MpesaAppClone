//
//  DatabaseService.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 11/06/2024.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class DatabaseService {
    static let instance = DatabaseService()
    
    func getCurrentUserID() async -> String {
        do {
            let result = try FirebaseAuth.instance.fetchAuthUser()
            return result.uid
        } catch {
            print("Error fetching current user")
            return ""
        }
    }
    
    func saveUserData(user: UserModel) async throws {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "phoneNumber": user.phoneNumber,
            "mpesaBalance": user.mpesaBalance
        ]
        // Save user data to Firestore
        try await db.collection("users").document(uid).setData(userData)
    }
    
    // MARK: Save Transaction history
    func saveTransactionHistory(transaction: Transaction) async throws {
        let db = Firestore.firestore()
        let transactionData: [String: Any] = [
            "firstName": transaction.contact?.givenName ?? "",
            "secondName": transaction.contact?.familyName ?? "",
            "phoneNumber": transaction.phoneNumber ?? "",
            "date": transaction.date,
            "amount": transaction.amount
        ]
        try await db.collection("transactions").addDocument(data: transactionData)
    }
    
    // MARK: Fetch Transaction history
    func fetchTransactionHistory() async throws -> [Transaction] {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection("transactions").whereField("userID", isEqualTo: uid).getDocuments()
        var transactions: [Transaction] = []
        
        for document in querySnapshot.documents {
            let data = document.data()
            let firstName = data["firstName"] as? String
            let secondName = data["secondName"] as? String
            let phoneNumber = data["phoneNumber"] as? String
            let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
            let amount = data["amount"] as? Double ?? 0.0
            let transaction = Transaction(
                contact: Contact(
                    givenName: firstName ?? "",
                    familyName: secondName ?? "",
                    mobileNumber: phoneNumber ?? ""
                ),
                phoneNumber: phoneNumber ?? "",
                date: date,
                amount: amount
            )
            transactions.append(transaction)
        }
        return transactions
    }

    
    // MARK: Add amount to mpesa balance
    func addUserBalance(newAmount: Double) async throws {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        // Fetch the user's document
        let docRef = db.collection("users").document(uid)
        let docSnapshot = try await docRef.getDocument()
        
        if let data = docSnapshot.data(), let currentBalance = data["mpesaBalance"] as? Double {
            // Update the balance
            let updatedBalance = currentBalance + newAmount
            try await docRef.updateData(["mpesaBalance": updatedBalance])
        } else {
            // Handle the case where the document does not exist or the current balance is not a Double
            throw NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user data or invalid balance"])
        }
    }
    
    // MARK: Deduct amount from mpesa balance
    func deductUserBalance(newAmount: Double) async throws {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        // Fetch the user's document
        let docRef = db.collection("users").document(uid)
        let docSnapshot = try await docRef.getDocument()
        if let data = docSnapshot.data(), let currentBalance = data["mpesaBalance"] as? Double {
            // Update the balance
            let updatedBalance = currentBalance - newAmount
            try await docRef.updateData(["mpesaBalance": updatedBalance])
        } else {
            // Handle the case where the document does not exist or the current balance is not a Double
            throw NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user data or invalid balance"])
        }
    }
    
    func updateUserBalance(newBalance: Double) async throws {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
         let docRef = db.collection("users").document(uid)
         try await docRef.updateData(["mpesaBalance": newBalance])
     }
    
    func fetchUserDetails() async throws -> UserModel {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        let docSnapshot = try await db.collection("users").document(uid).getDocument()
        guard let data = docSnapshot.data() else {
            print("No data found")
            throw URLError(.badServerResponse)
        }
        // etract data from doc snapshot
        let firstName = data["firstName"] as? String ?? "Hussein"
        let lastName = data["lastName"] as? String ?? "Aisak"
        let phoneNumber = data["phoneNumber"] as? String ?? ""
        let mpesaBalance = data["mpesaBalance"] as? Double ?? 0.0
        return UserModel(id: uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, mpesaBalance: mpesaBalance)
    }
    
    @discardableResult
    func callOnLaunch() async -> (UserModel?, [Transaction]?) {
        do {
            let user = try await fetchUserDetails()
            let transactions = try await fetchTransactionHistory()
            return (user, transactions)
        } catch {
            print("Error on call on launch \(error.localizedDescription)")
            return (nil, nil)
        }
    }
}
