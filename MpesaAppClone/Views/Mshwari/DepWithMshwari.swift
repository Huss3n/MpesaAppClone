//
//  DepWithMshwari.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 08/06/2024.
//

import SwiftUI

struct DepWithMshwari: View {
    @ObservedObject var savings = MpesaBalance.instance
    @State private var amount: Double = 0
    @FocusState var amountFocus: Bool
    var isDeposit: Bool = false
    
    @Binding var deposit: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: "xmark.circle")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onTapGesture {
                    deposit.toggle()
                }
                .padding(.horizontal)
            
            Text(isDeposit ? "DEPOSIT FROM M-PESA" : "WITHDRAW TO M-PESA")
                .fontWeight(.light)
                .padding(.top, 60)
            
            HStack {
                Text("KSH.")
                TextField("", value: $amount, format: .number)
                    .keyboardType(.numberPad)
                    .focused($amountFocus)
            }
            .offset(x: 160)
            .font(.title)
            .foregroundStyle(.primary)
            .padding(.top, 60)
            
            if !isDeposit {
                Text("SAVINGS BALANCE KSH: \( savings.mshwariBalance.formatted(.number.precision(.fractionLength(2)).grouping(.automatic)))")
                    .fontWeight(.light)
            } else {
                Text("M-PESA BALANCE KSH: \( savings.mpesaBalance.formatted(.number.precision(.fractionLength(2)).grouping(.automatic)))")
                    .fontWeight(.light)
            }
            
            Text("CONTINUE")
                .foregroundStyle(.black)
                .font(.headline)
                .padding()
                .padding(.horizontal, 80)
                .background(amount < 5 ? .white : .green)
                .clipShape(Capsule())
                .shadow(radius: 2)
                .onTapGesture {
                    Task.init {
                        let result = await LocalAuth.shared.authenticateWithBiometrics(reason: "Biometrics needed to deposit to savings")
                        if result {
                            if isDeposit {
                                await savings.deductMpesaBalanceAddToMshwari(depositAmount: amount)
                                deposit.toggle()
                            } else {
                                await savings.deductMshwariBalanceAddToMpesa(withdrawAmount: amount)
                                deposit.toggle()
                            }
                        }
                    }
                }
            
            Spacer()
        }
        .onAppear(perform: {
            amountFocus = true
        })
    }
}

#Preview {
    DepWithMshwari(deposit: .constant(true))
}
