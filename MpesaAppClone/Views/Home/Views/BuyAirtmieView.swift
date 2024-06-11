//
//  BuyAirtmieView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 03/06/2024.
//

import SwiftUI

struct BuyAirtmieView: View {
    @EnvironmentObject var navigationState: NavigationState
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @Environment(\.dismiss) var dismiss
    @State private var amount: Double = 0
    @State private var amountString: String = ""
    
    var phoneNumber = "0712345678"
    
    var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .onTapGesture {
                                dismiss()
                            }
                        
                        Spacer()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.gray)
                                .frame(width: 60, height: 6)
                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.green)
                                .frame(width: 14, height: 6, alignment: .leading)
                                .offset(x: -23)
                        }
                    }
                    
                    // replace with profile image
                    // fetch from firebase
                    Circle()
                        .fill(.gray.opacity(0.4))
                        .frame(width: 50, height: 50)
                        .overlay {
                            Text("HW")
                                .foregroundStyle(.blue)
                        }
                    
                    Text("HUSSEIN MUKTAR")
                    HStack {
                        Text("PHONE NUMBER")
                            .font(.headline)
                        
                        Text(phoneNumber)
                            .fontWeight(.light)
                    }

                    
                    Spacer()
                    
                    // MARK: Enter amount
                    HStack(alignment: .center) {
                        Text("KSH.")
                            .fontWeight(.ultraLight)
                        Text(amountString)
                            .foregroundStyle(amount < mpesaBalance.mpesaBalance ? Color.primary : Color.orange)
                            .onChange(of: amountString) { _, newValue in
                                if let newAmount = Double(amountString) {
                                    amount = newAmount
                                } else {
                                    amount = 0
                                }
                            }
                    }
                    .font(.title)
                    .fontWeight(.medium)
                    
                    
                    HStack {
                        Text("BALANCE: KSH. \(String(format: "%.2f", mpesaBalance.mpesaBalance))")
                            .fontWeight(.bold)
                        Text("FULIZA: KSH. 500.00")
                            .fontWeight(.light)
                    }
                    .foregroundStyle(amount < mpesaBalance.mpesaBalance ? Color.primary : Color.orange)
                    .font(.caption)
                    .padding(.bottom, 42)
                    
                    
                    // MARK: Continue button
                    VStack(spacing: 35) {
                        NavigationLink {
                            GenericConfirm(
                                initials: "HM",
                                amount: amount,
                                phoneNumber: phoneNumber,
                                agentNumber: "",
                                storeNumber: "",
                                withdrawalCost: 0,
                                transactionType: .airtime
                            )
                            .environmentObject(navigationState)
                            .navigationBarBackButtonHidden()
                        } label: {
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
                                    .fill(amount < 5 ? .black.opacity(0.3) : .green)
                                    .frame(height: 55)
                            )
                        }
                    }
                    .tint(.primary)
                    
                    // MARK: Numeric pad
                    VStack(spacing: 4) {
                        ForEach(0..<3) { row in
                            HStack(spacing: 30) {
                                ForEach(1...3, id: \.self) { column in
                                    NumberButton(number: "\(row * 3 + column)", action: {
                                        amountString.append("\(row * 3 + column)")
                                    })
                                }
                            }
                        }
                        HStack(spacing: 30) {
                            NumberButton(number: "", action: {}) // Placeholder for alignment
                            NumberButton(number: "0", action: {
                                amountString.append("0")
                            })
                            NumberButton(number: "X", action: {
                                if !amountString.isEmpty {
                                    amountString.removeLast()
                                }
                            })
                        }
                    }
                    .foregroundStyle(.primary)
                }
                .padding(.top, 30)
                .padding(.horizontal)
            }
    }
}

#Preview {
    BuyAirtmieView()
}
