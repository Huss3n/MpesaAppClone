//
//  LocalAuth.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 09/06/2024.
//

import Foundation
import LocalAuthentication

final class LocalAuth {
    static let shared = LocalAuth()
    
    init() { }
    
    private(set) var context = LAContext()
    private(set) var biometryType: LABiometryType = .none
    private(set) var canEvaluatePolicy: Bool = false
 
    
    // get the biometry type of the device
    func getBiometryType() -> LABiometryType {
        // check if device supports biometry auth
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }
    
    // auth user
    func authenticateWithBiometrics(reason: String) async -> Bool {
        context = LAContext()
        
        if canEvaluatePolicy {
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                return success
            } catch {
                print(error.localizedDescription)
                self.biometryType = .none // <- fall back to pin
                return false
            }
        } else {
            print("Biometry authentication not available.")
            return false
        }
    }
}
