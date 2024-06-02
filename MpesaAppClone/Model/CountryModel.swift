//
//  CountryModel.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 01/06/2024.
//

import Foundation

struct Country: Codable, Identifiable {
    let id: UUID = UUID()
    let name: CountryName
    let idd: IDD
    let flags: Flags

    
    struct CountryName: Codable {
        let common: String
    }
    
    struct IDD: Codable {
        let root: String
        let suffixes: [String]
    }
    
    struct Flags: Codable {
        let png: String
    }

}


