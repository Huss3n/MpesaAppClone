//
//  RandomID.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 09/06/2024.
//

import Foundation


final class RandomID {
    static let shared = RandomID()
    
    func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<11).map{ _ in letters.randomElement()! }).uppercased()
    }
}
