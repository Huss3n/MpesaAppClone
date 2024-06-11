//
//  SafariView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 04/06/2024.
//

import SwiftUI
import SafariServices

struct safari: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<safari>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: URL(string: "https://www.safaricom.co.ke/")!)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<safari>) {
    }
}
