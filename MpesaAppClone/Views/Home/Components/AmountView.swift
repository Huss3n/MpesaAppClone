//
//  AmountView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 30/05/2024.
//
import SwiftUI

import SwiftUI

struct AmountView: View {
    @EnvironmentObject var navigationState: NavigationState
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @Environment(\.dismiss) var dismiss
    @State private var amount: Double = 0
    @State private var amountString: String = ""
    @State private var addWithdrawalFees: Bool = false
    
    
    // compute withdrawal cost
    var withdrawalCost: Double {
        if amount > 50 && amount <= 100 {
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
            return 105
        }
        return 0.0
    }
    
    // to receive
    var contact: Contact?
    var phoneNumber: String = ""
    var sendOrRequest: SendOrRequest
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "arrow.left")
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
                            .frame(width: 30, height: 6, alignment: .leading)
                            .offset(x: -15)
                    }
                }
                .padding(.top, 20)
                
                // add the image from the contact and name here
                if !phoneNumber.isEmpty {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay {
                            Image(systemName: "person")
                                .font(.largeTitle)
                        }
                    
                    HStack {
                        Text("PHONE NUMBER")
                            .fontWeight(.semibold)
                        Text(phoneNumber)
                            .fontWeight(.light)
                    }
                } else {
                    // show contact info
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text(contact?.initials ?? "")
                        }
                    Text("\(contact?.givenName ?? "") \(contact?.familyName ?? "")")
                }
                
                Spacer()
                
                // MARK: Enter amount
                VStack(spacing: 20) {
                    HStack(alignment: .center) {
                        Text("KSH.")
                            .fontWeight(.ultraLight)
                        Text(amountString)
                            .foregroundStyle(amount < HomeVM.shared.mpesaBalance ? Color.primary : Color.orange)
                        // show mpesa balance and the fuliza amount
                    }
                    .font(.title)
                    .fontWeight(.medium)
                    
                    HStack {
                        Text("BALANCE: KSH. \(String(format: "%.2f", HomeVM.shared.mpesaBalance ))")
                            .fontWeight(.bold)
                        Text("FULIZA: KSH. 500.00")
                            .fontWeight(.light)
                    }
//                    .foregroundStyle(amount < HomeVM.shared.mpesaBalance  ? Color.primary : Color.primary)
                    .font(.caption)
                    
                    
                    if amount > 50 {
                        HStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(addWithdrawalFees ? .green : .clear)
                                .stroke(addWithdrawalFees ? .green : .black, lineWidth: 1.0)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(addWithdrawalFees ? .white : .clear)
                                }
                                .onTapGesture {
                                    addWithdrawalFees.toggle()
                                }
                            
                            Text("ADD WITHDRAWAL FEES ")
                                .foregroundStyle(.green)
                            +
                            Text("KSH.(\(String(format: "%.2f", withdrawalCost)))")
                        }
                        .font(.subheadline)
                        .padding(.top, 12)
                    }
                    
                }
                .padding(.horizontal, 20)
                .frame(width: 350, height: 120)
 
                // MARK: Continue button
                VStack(spacing: 35) {
                    NavigationLink {
                        ConfirmView(
                            sendOrRequest: sendOrRequest,
                            phoneNumber: phoneNumber,
                            amount: addWithdrawalFees ? amount + withdrawalCost : amount,
                            contact: contact
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
                                .fill(amount == 0 ? .black.opacity(0.3) : .green)
                                .frame(height: 55)
                        )
                    }

                    
                    // MARK: Numeric pad
                    VStack(spacing: 4) {
                        ForEach(0..<3) { row in
                            HStack(spacing: 30) {
                                ForEach(1...3, id: \.self) { column in
                                    AmountButton(number: row * 3 + column, action: {
                                        appendNumber(row * 3 + column)
                                    })
                                }
                            }
                        }
                        HStack(spacing: 30) {
                            AmountButton(number: nil, action: {}) // Placeholder for alignment
                            AmountButton(number: 0, action: {
                                appendNumber(0)
                            })
                            AmountButton(number: -1, action: {
                                if !amountString.isEmpty {
                                    amountString.removeLast()
                                    amount = Double(amountString) ?? 0
                                }
                            }, label: "X")
                        }
                    }
                    .foregroundStyle(.primary)
                }
                .padding(.top, 50)
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func appendNumber(_ number: Int) {
        amountString.append("\(number)")
        amount = Double(amountString) ?? 0
    }
}

struct AmountButton: View {
    let number: Int?
    let action: () -> Void
    var label: String? // Optional label parameter to display custom text
    
    var body: some View {
        Button(action: action) {
            Text(label ?? "\(number ?? 0)")
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: 100, height: 60)
        }
    }
}

#Preview {
    AmountView(phoneNumber: "0712345678", sendOrRequest: .request)
}
