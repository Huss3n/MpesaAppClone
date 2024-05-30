//
//  AmountView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 30/05/2024.
//
import SwiftUI

import SwiftUI

struct AmountView: View {
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @Environment(\.dismiss) var dismiss
    @State private var amount: Double = 0
    @State private var amountString: String = ""
    
    // to receive
    var contact: Contact?
    var phoneNumber: String = ""
    
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
                VStack {
                    HStack(alignment: .center) {
                        Text("KSH.")
                            .fontWeight(.ultraLight)
                        Text(amountString)
                            .foregroundStyle(amount < mpesaBalance.mpesaBalance ? Color.primary : Color.orange)
                        // show mpesa balance and the fuliza amount
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
                }
                .padding(.horizontal, 20)
                .frame(width: 350, height: 120)
                
                // MARK: Continue button
                VStack(spacing: 35) {
                    Button(action: {
                        // Continue button action
                        print("Continue pressed with amount: \(amount)")
                    }) {
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
                    .disabled(amount == 0)
                    
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
    AmountView(phoneNumber: "0712345678")
}
