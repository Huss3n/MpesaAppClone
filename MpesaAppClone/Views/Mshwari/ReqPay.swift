//
//  ReqPay.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI

struct ReqPay: View {
    @EnvironmentObject var navState: MshwariNavigationState
    @Environment(\.dismiss) var dismiss
    @ObservedObject var loanBalance = MpesaBalance.instance
    @State private var navigateToLoan: Bool = false
    @State private var navigateToPay: Bool = false
    @State private var loanAmountString: String = ""
    @Binding var reqPay: ReqPayPath
    @Binding var navigate: Bool
    
    let availableLimit: Double = 14_000
    
    var loanAmount: Double {
        return Double(loanAmountString) ?? 0
    }

    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "xmark.circle")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                    .padding(.top, 20)
                    .onTapGesture {
                        if reqPay == .loan {
                            navigate = false
                        } else {
                            navigate = false
                        }
                    }
                
                Spacer()
                
                Text(reqPay == .loan ? "REQUST LOAN" : "PAY LOAN")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.bottom, 120)
                
                
                VStack(spacing: 20) {
                    HStack(alignment: .center) {
                        Text("KSH.")
                            .fontWeight(.ultraLight)
                        Text(loanAmountString)
                            .foregroundStyle(loanAmount < availableLimit ? Color.primary : Color.orange)
                        // show mpesa balance and the fuliza amount
                    }
                    .font(.title)
                    .fontWeight(.medium)
                    
                    if reqPay == .loan {
                        Text("Available Limit: KSH. \(String(format: "%.2f", availableLimit))")
                            .fontWeight(.bold)
                            .foregroundStyle(loanBalance.loanBalance < availableLimit ? Color.primary : Color.orange)
                            .font(.caption)
                    } else {
                        Text("Loan Amount: KSH. \(String(format: "%.2f", loanBalance.loanBalance))")
                            .fontWeight(.bold)
                            .foregroundStyle(HomeVM.shared.mpesaBalance  < loanAmount ? Color.primary : Color.orange)
                            .font(.caption)
                    }
                    HStack {
                        Text("Continue".uppercased())
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Image(systemName: "arrow.right")
                            .imageScale(.large)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(loanAmount <= 10 ? .black.opacity(0.3) : .green)
                            .frame(height: 55)
                    )
                    .padding(.top, 40)
                    .onTapGesture {
                        if reqPay == .loan {
                            navigateToLoan.toggle()
                        } else {
                            navigateToPay.toggle()
                        }
                    }
                }
                .padding(.bottom, 100)
                
                
                
                // MARK: Numeric pad
                VStack(spacing: 4) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 30) {
                            ForEach(1...3, id: \.self) { column in
                                NumberButton(number: "\(row * 3 + column)", action: {
                                    loanAmountString.append("\(row * 3 + column)")
                                })
                            }
                        }
                    }
                    HStack(spacing: 30) {
                        NumberButton(number: "", action: {}) // Placeholder for alignment
                        NumberButton(number: "0", action: {
                            loanAmountString.append("0")
                        })
                        NumberButton(number: "X", action: {
                            if !loanAmountString.isEmpty {
                                loanAmountString.removeLast()
                            }
                        })
                    }
                }
                .foregroundStyle(.primary)
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $navigateToLoan) {
                ConfirmReqPay(reqPayPath: .loan, loanAmount: loanAmount,  isMpesa: true)
                    .environmentObject(navState)
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $navigateToPay) {
                FundsOriginPath(amount: loanAmount)
                    .environmentObject(navState)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    ReqPay(reqPay: .constant(.loan), navigate: .constant(true))
}
