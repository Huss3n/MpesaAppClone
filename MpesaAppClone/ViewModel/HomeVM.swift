//
//  HomeVM.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 11/06/2024.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage


class HomeVM {
    static let shared = HomeVM()
    
    private func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Image download failed", code: 0, userInfo: nil)
        }
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "Invalid image data", code: 0, userInfo: nil)
        }
        return image
    }
}
