//
//  NumericPad.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 30/05/2024.
//

import SwiftUI

struct NumericPad: View {
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.dismiss) var dismiss
    @State private var phoneNumber: String = ""
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
                            .frame(width: 14, height: 6, alignment: .leading)
                            .offset(x: -23)
                    }
                }
                
                Text(sendOrRequest == .send ? "Send money".uppercased() : "request money".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .padding(.top, 10)
//                    .padding(.bottom, 120)
                
                Spacer()
                
                // MARK: Enter phone number
                ZStack(alignment: .center) {
                    if phoneNumber.isEmpty {
                        Text("Enter phone number")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                    }
                    VStack {
                        if !phoneNumber.isEmpty {
                            Text("Enter phone number")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(.green)
                        }
                        
                        TextField("", text: $phoneNumber)
                            .font(.title)
                            .fontWeight(.light)
                            .keyboardType(.numberPad)
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                        
                        if phoneNumber.count > 10 {
                            Text("Phone number is invalid")
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundColor(.red)
                        }
                    }
                     
                }
                .padding(.horizontal, 20)
                .frame(width: 300, height: 120)
                .padding(.bottom, 30)
    //            .background(.blue)

                
                // MARK: Continue button
                VStack(spacing: 35) {
                    NavigationLink {
                        AmountView(phoneNumber: phoneNumber, sendOrRequest: sendOrRequest)
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
                                    .fill(phoneNumber.count != 10 ? .black.opacity(0.3) : .green)
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
                                        phoneNumber.append("\(row * 3 + column)")
                                    })
                                }
                            }
                        }
                        HStack(spacing: 30) {
                            NumberButton(number: "", action: {}) // Placeholder for alignment
                            NumberButton(number: "0", action: {
                                phoneNumber.append("0")
                            })
                            NumberButton(number: "X", action: {
                                if !phoneNumber.isEmpty {
                                    phoneNumber.removeLast()
                                }
                            })
                        }
                    }
                    .foregroundStyle(.primary)
                }
                .padding(.top, 30)
            }
            .padding(.horizontal, 20)
        }
    }




#Preview {
    NumericPad(sendOrRequest: .request)
}

struct NumberButton: View {
    let number: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(number)
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: 100, height: 60)
        }
    }
}
