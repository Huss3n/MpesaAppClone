//
//  PhotoPicker.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 27/05/2024.
//

import SwiftUI
import PhotosUI


struct PhotoPicker: View {
    var body: some View {
        Image("profile")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
//            .frame(width: 100, height: 100)
    }
}

#Preview {
    PhotoPicker()
}
