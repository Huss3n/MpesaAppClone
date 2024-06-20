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
            fatalError("No id found")
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
    
    func saveRequestState() async throws {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        let userData: [String: Any] = ["requestStatus": false]
        // Save user data to Firestore
        try await db.collection("requestState").document(uid).setData(userData)
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
        
        print(mpesaBalance)
        return UserModel(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, mpesaBalance: mpesaBalance)
    }
    
    func fetchRequestState() async throws -> Bool? {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        let docSnapshot = try await db.collection("requestState").document(uid).getDocument()
        guard let data = docSnapshot.data() else {
            print("No data found")
            throw URLError(.badServerResponse)
        }
        // etract data from doc snapshot
        let reqeustStatus = data["requestStatus"] as? Bool ?? nil
        return reqeustStatus ?? nil

    }
    
    func initiateRequest(phoneNumber: String) async throws {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        // Create a query to find the user with the given phone number
        let query = usersCollection.whereField("phoneNumber", isEqualTo: phoneNumber)
        
        let snapshot = try await query.getDocuments()
        
        // Check if a user with the given phone number exists
        guard let document = snapshot.documents.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        print(document.documentID)
        
        // Flip the request state to false
        let requestStateRef = db.collection("requestState").document(document.documentID)
        try await requestStateRef.updateData(["requestStatus": true])
//        try await requestStateRef.setData(["requestStatus": true, "amount": amount])
        
        // Show the prompt to the user for approval
        // This part would depend on your UI implementation
    }
    
    func approveRequest(receiverPhoneNumber: String, sendersPhoneNumber: String) async throws {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        // Create a query to find the user with the given phone number
        let receiverQuery = usersCollection.whereField("phoneNumber", isEqualTo: receiverPhoneNumber)
        let receiverSnapshot = try await receiverQuery.getDocuments()
        
        // Check if a user with the given phone number exists
        guard let receiverDocument = receiverSnapshot.documents.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Receiver not found"])
        }
        
        // Fetch receiver's balance
        let receiverData = receiverDocument.data()
        let receiverBalance = receiverData["mpesaBalance"] as? Double ?? 0.0
        let newReceiverBalance = receiverBalance + 500
        
        // Create a query to find the sender with the given phone number
        let senderQuery = usersCollection.whereField("phoneNumber", isEqualTo: sendersPhoneNumber)
        let senderSnapshot = try await senderQuery.getDocuments()
        
        // Check if a user with the given phone number exists
        guard let senderDocument = senderSnapshot.documents.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sender not found"])
        }
        // Fetch sender's balance
        let senderData = senderDocument.data()
        let senderBalance = senderData["mpesaBalance"] as? Double ?? 0.0
        guard senderBalance >= 500 else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Insufficient balance"])
        }
        let newSenderBalance = senderBalance - 500
        
        // Update receiver's balance
        try await db.collection("users").document(receiverDocument.documentID).updateData(["mpesaBalance": newReceiverBalance])
        
        // Update sender's balance
        try await db.collection("users").document(senderDocument.documentID).updateData(["mpesaBalance": newSenderBalance])
        
        // MARK: Update the request state to false
        let senderRequestDoc = try await db.collection("requestState").document(senderDocument.documentID).getDocument()
        try await senderRequestDoc.reference.updateData(["requestStatus": false])
    }

    func startListeningForRequestApproval(phoneNumber: String) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        // Create a query to find the user with the given phone number
        let query = usersCollection.whereField("phoneNumber", isEqualTo: phoneNumber)
        
        query.getDocuments { (snapshot, error) in
            guard let document = snapshot?.documents.first else {
                print("User not found")
                return
            }
            
            let requestStateRef = db.collection("requestState").document(document.documentID)
            
            requestStateRef.addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot, document.exists else {
                    print("Document does not exist")
                    return
                }
                
                let data = document.data() ?? [:]
                let requestStatus = data["requestStatus"] as? Bool ?? false
                let amount = data["amount"] as? Double ?? 0.0
                
                if requestStatus {
                    Task {
                        do {
                            try await self.deductAmount(phoneNumber: phoneNumber, amount: amount)
                            // Flip the request state back to false after deduction
                            try await requestStateRef.updateData(["requestStatus": false])
                        } catch {
                            print("Failed to deduct amount: \(error)")
                        }
                    }
                }
            }
        }
    }

    func deductAmount(phoneNumber: String, amount: Double) async throws {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        // Create a query to find the user with the given phone number
        let query = usersCollection.whereField("phoneNumber", isEqualTo: phoneNumber)
        
        let snapshot = try await query.getDocuments()
        
        // Check if a user with the given phone number exists
        guard let document = snapshot.documents.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        
        // Extract the user's current mpesa balance
        var data = document.data()
        guard let currentBalance = data["mpesaBalance"] as? Double else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "mpesaBalance not found"])
        }
        
        // Check if the current balance is sufficient to deduct the amount
        guard currentBalance >= amount else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Insufficient balance"])
        }
        
        // Deduct the amount from the current balance
        let newBalance = currentBalance - amount
        
        // Update the user's balance in Firestore
        try await document.reference.updateData(["mpesaBalance": newBalance])
    }

    // MARK: Save Transaction history
    func saveTransactionHistory(transaction: Transaction) async throws {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        let transactionData: [String: Any] = [
            "firstName": transaction.contact?.givenName ?? "",
            "secondName": transaction.contact?.familyName ?? "",
            "phoneNumber": transaction.phoneNumber ?? "",
            "date": transaction.date,
            "amount": transaction.amount
        ]
        let docRef = db.collection("users").document(uid)
        
       _ = try await db.runTransaction { (transaction, errorPointer) -> Any? in
            let docSnapshot: DocumentSnapshot
            do {
                docSnapshot = try transaction.getDocument(docRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            var transactionsArray = docSnapshot.data()?["transactions"] as? [[String: Any]] ?? []
            transactionsArray.append(transactionData)
            transaction.updateData(["transactions": transactionsArray], forDocument: docRef)
            return nil
        }
    }
    
    // MARK: Fetch Transaction history
    func fetchTransactionHistory() async throws -> [Transaction] {
        let uid = await getCurrentUserID()
        let db = Firestore.firestore()
        let docSnapshot = try await db.collection("users").document(uid).getDocument()
        guard let data = docSnapshot.data(), let transactionsArray = data["transactions"] as? [[String: Any]] else {
            return []
        }
        var transactions: [Transaction] = []
        for transactionData in transactionsArray {
            let firstName = transactionData["firstName"] as? String
            let secondName = transactionData["secondName"] as? String
            let phoneNumber = transactionData["phoneNumber"] as? String
            let date = (transactionData["date"] as? Timestamp)?.dateValue() ?? Date()
            let amount = transactionData["amount"] as? Double ?? 0.0
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
            
            print("transaction")
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
    
    // MARK: Fetch user by phone number and update balance
    @discardableResult
    func updateUserBalanceByPhoneNumber(phoneNumber: String, addAmount: Double) async throws -> UserModel? {
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection("users").whereField("phoneNumber", isEqualTo: phoneNumber).getDocuments()
        guard let document = querySnapshot.documents.first else {
            print("User with phone number \(phoneNumber) not found")
            return nil
        }
        let data = document.data()
        guard let currentBalance = data["mpesaBalance"] as? Double else {
            throw NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid mpesa balance"])
        }
        let updatedBalance = currentBalance + addAmount
        try await document.reference.updateData(["mpesaBalance": updatedBalance])
        
        return UserModel(
            firstName: data["firstName"] as? String ?? "Hussein",
            lastName: data["lastName"] as? String ?? "Aisak",
            phoneNumber: phoneNumber,
            mpesaBalance: updatedBalance
        )
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
