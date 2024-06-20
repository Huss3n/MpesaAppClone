//
//  Root.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 12/06/2024.
//

import SwiftUI

struct Root: View {
    @AppStorage("userLoggedIn") var userLoggedIn: Bool = false
    let user = UserModel(firstName: "Hussein", lastName: "Aisak", phoneNumber: "12345678", mpesaBalance: 0)
    
    var body: some View {
        ZStack {
            if userLoggedIn {
                // show main view
                MainTab(user: user)
            } else {
                // show login view
                Register()
            }
        }
    }
}

#Preview {
    Root()
}
