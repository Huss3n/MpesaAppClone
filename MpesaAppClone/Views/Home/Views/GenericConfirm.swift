//
//  GenericConfirm.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 03/06/2024.
//

import SwiftUI

struct GenericConfirm: View {
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var successfulWithdraw: Bool = false
    @State private var successfulAirtime: Bool = false
    
    var initials: String
    var amount: Double
    var phoneNumber: String
    var agentNumber: String
    var storeNumber: String
    var withdrawalCost: Double // for withdraw
    
    var transactionCost: Double {
        if amount < 49 && amount <= 100 {
            return 11
        } else if amount > 100 && amount <= 2500 {
            return 29
        } else if amount > 2500 && amount <= 3500 {
            return 52
        } else if amount > 3500 && amount <= 5000 {
            return 69
        } else if amount > 5000 && amount <= 7500 {
            return 87
        } else if amount > 7500 && amount <= 10_000 {
            return 115
        } else if amount > 10_000 && amount <= 15_000 {
            return 167
        } else if amount > 15_000 && amount <= 20_000 {
            return 185
        }
        return 0.0
    }
    
    var transactionType: TransactionType
    
    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    
                    Text("CONFIRM")
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray)
                            .frame(width: 60, height: 6)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.green)
                            .frame(width: 50, height: 6, alignment: .leading)
                            .offset(x: -10)
                    }
                }
                .padding(.top, 20)
                
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(colorScheme == .light ? .gray.opacity(0.15) : .white.opacity(0.05))
                        .frame(height: 100)
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
                        .frame(height: 460)
                        .overlay {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(transactionType == .withdraw ? "WITHDRAW" : "BUY AIRTIME")
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .background(colorScheme == .light ? .black.opacity(0.4) : .white.opacity(0.05))
                                    .cornerRadius(25)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .offset(y: -20)
                             
                                    // show contact info
                                    Circle()
                                        .fill(.gray.opacity(0.3))
                                        .frame(width: 100, height: 100)
                                        .overlay {
                                            Text(initials)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .offset(y: -30)
                                
                                Text(transactionType == .airtime ? "BUY TO" : "WITHDRAW TO")
                                    .foregroundStyle(.gray)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                
                                Text(transactionType == .airtime ? "HUSSEIN MUKTAR" : "HElLO WORLD")
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                
                                Text(transactionType == .withdraw ? "AGENT NUMBER" : "PHONE NUMBER")
                                        .foregroundStyle(.gray)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 8)

                                
                                Text(transactionType == .withdraw ? agentNumber : phoneNumber)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                
                      
                                
                                Text("AMOUNT")
                                    .foregroundStyle(.gray)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                
                                HStack {
                                    Text("KSH. \(String(format: "%.2f", amount))")
                                    Spacer()
                                    Image(systemName: "pencil")
                                        .imageScale(.large)
                                        .foregroundStyle(.white)
                                        .background(
                                            Circle()
                                                .fill(.black.opacity(0.8))
                                                .frame(width: 30, height: 30)
                                        )
                                        .onTapGesture {
                                            dismiss()
                                        }
                                }
                                .padding(.horizontal, 8)
                                
                                Text("FEE: KSH. \(String(format: "%.2f", transactionCost))")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .padding(.horizontal, 8)
                                
                                
                                Rectangle()
                                    .fill(.gray)
                                    .frame(height: 1)
                                    .padding(.vertical)
                            }
                            .padding(.horizontal, 4)
                            
                        }
                }
                .padding(.top, 50)
                
                HStack {
                    Text(transactionType == .withdraw ? "withdraw".uppercased() : "buy airtime".uppercased())
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
                        .fill(.green)
                        .frame(height: 55)
                )
                .padding(.top, 40)
                .onTapGesture {
                    if transactionType == .withdraw {
                        successfulWithdraw.toggle()
                    } else if transactionType == .airtime {
                        successfulAirtime.toggle()
                    }
                }
                
                Spacer()
            }
            .onAppear {
                print("Agent \(agentNumber)")
                print("Store \(storeNumber)")
                print("Withdrawal cost: \(withdrawalCost)")
            }
            .padding(.horizontal)
            .sheet(isPresented: $successfulWithdraw,
                   content: {
                PinFallback(
                    cancel: $successfulWithdraw,
                    amount: amount,
                    transactionCost: withdrawalCost,
                    transactionType: transactionType,
                    agentNumber: agentNumber,
                    storeNumber: storeNumber
                )
                .environmentObject(navigationState)
            })
            .sheet(isPresented: $successfulAirtime,
                   content: {
                PinFallback(
                    cancel: $successfulAirtime,
                    amount: amount,
                    transactionCost: 0,
                    transactionType: transactionType,
                    agentNumber: transactionType == .withdraw ? agentNumber : "",
                    storeNumber: transactionType == .withdraw ? storeNumber : ""
                )
                .environmentObject(navigationState)
            })
    }
}

#Preview {
    GenericConfirm(initials: "HW", amount: 20, phoneNumber: "07000000", agentNumber: "1234", storeNumber: "1234", withdrawalCost: 20, transactionType: .withdraw)
        .environmentObject(NavigationState())
}
