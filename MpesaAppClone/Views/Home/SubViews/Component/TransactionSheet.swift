//
//  TransactionSheet.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 29/05/2024.
//

import SwiftUI

struct TransactionSheet: View {
    var transactionTitle: String
    var isImageSystem: Bool
    
    var imageName1: String
    var transaction1: String
    var background: Color
    
    var imageName2: String
    var transaction2: String
    
    var imageName3: String
    var transaction3: String
    
    var imageName4: String
    var transaction4: String
    
    var imageName5: String
    var transaction5: String
    
    var buttonPressed1: () -> Void
    var buttonPressed2: () -> Void
    var buttonPressed3: () -> Void
    var buttonPressed4: () -> Void
    var buttonPressed5: () -> Void
    
    
    @State private var sendReqeust: Bool = false
    @State private var global: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.gray.opacity(0.66))
                .frame(width: 60, height: 8)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(transactionTitle.uppercased())
                .fontWeight(.light)
            
            // MARK: Transaction 1
            TransactionSheetObject(
                isImageSystem: isImageSystem,
                imageName: imageName1,
                transaction: transaction1,
                background: background
            )
            .onTapGesture {
                buttonPressed1()
            }

           // MARK: Transaction 2
            TransactionSheetObject(
                isImageSystem: isImageSystem,
                imageName: imageName2,
                transaction: transaction2,
                background: background
            )
            .onTapGesture {
                buttonPressed2()
            }

            // MARK: Transaction 3
            TransactionSheetObject(
                isImageSystem: isImageSystem,
                imageName: imageName3,
                transaction: transaction3,
                background: background
            )
            .onTapGesture {
                buttonPressed3()
            }

            // MARK: Transaction 4
            TransactionSheetObject(
                isImageSystem: isImageSystem,
                imageName: imageName4,
                transaction: transaction4,
                background: background
            )
            .onTapGesture {
                buttonPressed4()
            }

            // MARK: Transaction 5
            TransactionSheetObject(
                isImageSystem: isImageSystem,
                imageName: imageName5,
                transaction: transaction5,
                background: background
            )
            .onTapGesture {
                buttonPressed5()
            }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 30)
    }
}

//#Preview {
//    TransactionSheet(
//        transactionTitle: "send and request",
//        isImageSystem: true,
//        imageName1: "arrow.up.right",
//        transaction1: "send money", 
//        background: .green,
//        imageName2: "arrow.down.backward",
//        transaction2: "request money",
//        imageName3: "globe",
//        transaction3: "GLOBAL",
//        imageName4: "qrcode",
//        transaction4: "Scan qr",
//        imageName5: "",
//        transaction5: "",
//        buttonPressed: { }
//    )
//}


struct TransactionSheetObject: View {
    var isImageSystem: Bool
    var imageName: String
    var transaction: String
    var background: Color
    var body: some View {
        HStack {
            if !transaction.isEmpty {
                if isImageSystem {
                    Image(systemName: imageName)
                        .imageScale(.medium)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(background)
                        .clipShape(Circle())
                } else {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .background(.blue.opacity(0.3))
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                }
                Text(transaction.uppercased())
                    .font(.subheadline)
            }
        }
    }
}



