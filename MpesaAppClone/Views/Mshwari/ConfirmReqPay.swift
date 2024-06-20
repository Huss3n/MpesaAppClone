//
//  ConfirmReqPay.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI

struct ConfirmReqPay: View {
    @EnvironmentObject var navState: MshwariNavigationState
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var loanBalance = MpesaBalance.instance
    var reqPayPath: ReqPayPath
    var loanAmount: Double
    var isMpesa: Bool
    
    
    var fundsOrigin: String {
        if isMpesa {
            return "M-PESA"
        } else {
            return "M-SHWARI"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                
                Spacer()
            }
            .padding(.top, 20)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(colorScheme == .light ? .gray.opacity(0.15) : .white.opacity(0.05))
                    .frame(height: 120)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 25,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 25
                        )
                    )
                
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(colorScheme == .light ? .gray.opacity(0.066) : .white.opacity(0.11))
                    .shadow(radius: 4)
                    .frame(height: reqPayPath == .loan ? 450 : 350)
                    .overlay {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(reqPayPath == .loan ? "REQUEST LOAN" : "PAY LOAN")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .offset(y: -80)
                            
                            Image(reqPayPath == .loan ? "request" : "payLoan")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                                .background(
                                    Circle()
                                        .foregroundStyle(.gray.opacity(0.4))
                                )
                            
                            Text(reqPayPath == .loan ? "DURATION" : "FUNDS ORIGIN")
                                .foregroundStyle(.gray)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 8)
                            
                            Text(reqPayPath == .loan ? "30 DAYS" : fundsOrigin)
                                .foregroundStyle(.gray)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 8)
                            
                            
                            Text("AMOUNT")
                                .foregroundStyle(.gray)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 8)
                                .padding(.top, 32)
                            
                            HStack {
                                Text("KSH. \(String(format: "%.2f", loanAmount))")
                                Spacer()
                                Image(systemName: "pencil")
                                    .foregroundStyle(.black)
                                    .imageScale(.large)
                                    .background(
                                        Circle()
                                            .fill(.gray.opacity(0.6))
                                            .frame(width: 30, height: 30)
                                    )
                                    .onTapGesture {
                                        dismiss()
                                    }
                            }
                            .padding(.horizontal, 8)
                            
                            Text("TOTAL FEE: KSH.")
                                .font(.caption)
                                .fontWeight(.light)
                                .padding(.horizontal, 8)
                                .opacity(reqPayPath == .loan ? 1 : 0)
                        }
                        .padding(.horizontal, 4)
                        
                    }
            }
            .padding(.top, reqPayPath == .pay ? 160 : 40)
            
            HStack {
                Text("SEND REQUEST")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.green)
                    .frame(height: 55)
            )
            .padding(.top, reqPayPath == .pay ? 120 : 50)
            .onTapGesture {
                Task {
                    let result = await LocalAuth.shared.authenticateWithBiometrics(reason:"Biometrics needed to take out loan")
                    if result {
                        if reqPayPath == .loan {
                            await loanBalance.addLoanAmountToMpesaBalance(loanAmount: loanAmount)
                            navState.navigateToRoot = true
                        } else {
                            await loanBalance.payLoan(amount: loanAmount)
                            navState.navigateToRoot = true
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    ConfirmReqPay(reqPayPath: .loan, loanAmount: 0.0, isMpesa: true)
}
