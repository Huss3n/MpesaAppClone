//
//  User.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 10/06/2024.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

struct UserModel: Codable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var imageURL: String?
    var image: UIImage?
    var mpesaBalance: Double
    
    init(id: String? = nil, firstName: String, lastName: String, phoneNumber: String, imageURL: String? = nil, image: UIImage? = nil, mpesaBalance: Double) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.imageURL = imageURL
        self.image = image
        self.mpesaBalance = mpesaBalance
    }

    enum CodingKeys: CodingKey {
        case id
        case firstName
        case lastName
        case phoneNumber
        case imageURL
        case mpesaBalance
    }
}
