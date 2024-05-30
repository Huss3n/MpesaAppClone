//
//  Contact.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 30/05/2024.
//

import Foundation


struct Contact: Identifiable {
    let id = UUID()
    let givenName: String
    let familyName: String
    let mobileNumber: String?
    var initials: String {
        // Return the first and second letter of the names to use as the picture. If only one name is available return that one name
        let givenInitial = givenName.first.map { String($0) } ?? ""
        let familyInitial = familyName.first.map { String($0) } ?? ""
        return (givenInitial + familyInitial).uppercased()
    }
}
