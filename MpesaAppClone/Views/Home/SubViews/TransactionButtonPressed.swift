//
//  SendMoney.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 29/05/2024.
//

import SwiftUI

struct TransactionButtonPressed: View {
    @Binding var detentHeight: CGFloat
    var transactionType: TransactionType
    var callToAction: () -> (Void)
    
    var body: some View {
        if transactionType == .sendMoney {
            TransactionSheet(
                transactionTitle: "send and request",
                isImageSystem: true,
                imageName1: "arrow.up.right",
                transaction1: "send money",
                background: .green,
                imageName2: "arrow.down.backward",
                transaction2: "request money",
                imageName3: "globe",
                transaction3: "GLOBAL",
                imageName4: "qrcode",
                transaction4: "Scan qr",
                imageName5: "",
                transaction5: "", 
                buttonPressed: {
                    callToAction()
                }
            )
            .presentationDetents([.fraction(detentHeight)])
            
        } else if transactionType == .pay {
            TransactionSheet(
                transactionTitle: "pay",
                isImageSystem: true,
                imageName1: "chart.bar.doc.horizontal",
                transaction1: "pay bill",
                background: .blue,
                imageName2: "basket",
                transaction2: "buy goods",
                imageName3: "iphone.gen3",
                transaction3: "pochi la biashara",
                imageName4: "creditcard",
                transaction4: "global pay",
                imageName5: "qrcode.viewfinder",
                transaction5: "scan qr",
                buttonPressed: {callToAction()}
            )
            .presentationDetents([.fraction(detentHeight)])
            
        } else if transactionType == .withdraw {
            TransactionSheet(
                transactionTitle: "withdraw",
                isImageSystem: true,
                imageName1: "house",
                transaction1: "withdraw",
                background: .pink,
                imageName2: "banknote",
                transaction2: "withdraw at atm",
                imageName3: "qrcode",
                transaction3: "scan qr",
                imageName4: "",
                transaction4: "",
                imageName5: "",
                transaction5: "",
                buttonPressed: {callToAction()}
            )
            .presentationDetents([.fraction(detentHeight)])
            
        } else {
            TransactionSheet(
                transactionTitle: "airtime",
                isImageSystem: true,
                imageName1: "phone.arrow.down.left.fill",
                transaction1: "buy for my number",
                background: .blue.opacity(0.6),
                imageName2: "phone.arrow.up.right.fill",
                transaction2: "buy for other number",
                imageName3: "iphone.gen2.radiowaves.left.and.right",
                transaction3: "buy bundles",
                imageName4: "",
                transaction4: "",
                imageName5: "",
                transaction5: "",
                buttonPressed: {callToAction()}
            )
            .presentationDetents([.fraction(detentHeight)])
        }
    }
}

#Preview {
    TransactionButtonPressed(detentHeight: .constant(0.5), transactionType: .airtime, callToAction: { }
    )
}
