//
//  FirebaseAuth.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 10/06/2024.
//
import Foundation
import Firebase
import FirebaseAuth
import FirebaseAuthCombineSwift
import FirebaseFirestore
import FirebaseStorage

struct AuthDataResult {
    let uid: String
    let phoneNumber: String
    
    init(user: User) {
        self.uid = user.uid
        self.phoneNumber = user.phoneNumber ?? ""
    }
}

class FirebaseAuth {
    static let instance = FirebaseAuth()
    
    // send verification code
    func sendVerificationCode(for phoneNumber: String) async throws {
        let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
    }
    
    // verify the code and create user account
    
    func verifyUserCode(verificationCode: String, completion: @escaping (Bool, AuthDataResult?) -> Void) async throws {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { throw URLError(.badURL) }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        do {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            completion(true, AuthDataResult(user: authDataResult.user))
        } catch {
            print("error verifying user \(error.localizedDescription)")
            completion(false, nil)
        }
            
    }
    
    // returns the authenticated user
    func fetchAuthUser() throws -> AuthDataResult {
        guard let currentUser = Auth.auth().currentUser else { throw URLError(.badURL) }
        return AuthDataResult(user: currentUser)
    }

    func logout() async {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error logging out")
        }
       
    }
}

