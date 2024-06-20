//
//  IncomingRequest.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 14/06/2024.
//

import SwiftUI

struct IncomingRequest: View {
    var name: String
    var amount: Double
    @Environment(\.dismiss) var dismiss
    var approvedTransaction: () -> ()
    
    var body: some View {
       RoundedRectangle(cornerRadius: 25.0)
            .fill(.white.opacity(0.3))
            .frame(width: 370, height: 320)
            .shadow(radius: 4)
            .overlay {
                VStack(spacing: 12) {
                    Text("INCOMING REQUEST")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("\(name.uppercased())")
                        .foregroundStyle(.blue)
                        .fontWeight(.semibold)
                    +
                    
                    Text(" is requesting an amount of KSH. \(String(format: "%.2f", amount )) from you. To accept this transaction click")
                    +
                    Text(" APPROVE")
                        .foregroundStyle(.green)
                        .fontWeight(.semibold)
                    
                    +
                    Text(" To cancel this transaction click")
                    +
                    Text(" DECLINE")
                        .foregroundStyle(.red)
                        .fontWeight(.semibold)
                    
                    Text("APPROVE")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(10)
                        .padding(.horizontal, 60)
                        .background(.green)
                        .clipShape(Capsule())
                        .padding(.top, 12)
                        .onTapGesture {
                            Task {
                                let success = await LocalAuth.shared.authenticateWithBiometrics(reason: "Biometrics needed for transaction")
                                
                                if success {
                                    approvedTransaction()
                                }
                            }
                        }
                    
                    Text("DECLINE")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(10)
                        .padding(.horizontal, 60)
                        .background(.red)
                        .clipShape(Capsule())
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Spacer()
                }
                .multilineTextAlignment(.center)
                .padding(.top, 32)
                .lineSpacing(7)
                .padding(.horizontal)
                .font(.headline)
                .fontWeight(.light)
            }
    }
}
//
//#Preview {
////    IncomingRequest()
//}
