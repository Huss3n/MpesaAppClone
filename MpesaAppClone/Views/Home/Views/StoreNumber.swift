//
//  StoreNumber.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 10/06/2024.
//

import SwiftUI

struct StoreNumber: View {
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.dismiss) var dismiss
    @State private var storeNumber: String = ""
    var agentNumber: String

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
                
                
                Circle()
                    .fill(.gray.opacity(0.4))
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("HW")
                            .foregroundStyle(.blue)
                    }
                
                Text("HELLO WORLD")
                HStack {
                    Text("AGENT NUMBER")
                        .font(.headline)
                    
                    Text(agentNumber)
                        .fontWeight(.light)
                }

                
                Spacer()
                
                // MARK: Enter phone number
                ZStack(alignment: .center) {
                    if storeNumber.isEmpty {
                        Text("Enter Store Number")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                    }
                    VStack {
                        if !storeNumber.isEmpty {
                            Text("Enter Agent number")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(.green)
                        }
                        
                        TextField("", text: $storeNumber)
                            .font(.title)
                            .fontWeight(.light)
                            .keyboardType(.numberPad)
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                    
                }
                .padding(.horizontal, 20)
                .frame(width: 300, height: 120)
                .padding(.bottom, 30)
                //            .background(.blue)
                
                
                // MARK: Continue button
                VStack(spacing: 35) {
                    NavigationLink {
                        WithdrawAmount(agentNumber: agentNumber, storeNumber: storeNumber)
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
                                .fill(storeNumber.count != 4 ? .black.opacity(0.3) : .green)
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
                                    storeNumber.append("\(row * 3 + column)")
                                })
                            }
                        }
                    }
                    HStack(spacing: 30) {
                        NumberButton(number: "", action: {}) // Placeholder for alignment
                        NumberButton(number: "0", action: {
                            storeNumber.append("0")
                        })
                        NumberButton(number: "X", action: {
                            if !storeNumber.isEmpty {
                                storeNumber.removeLast()
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
    StoreNumber(agentNumber: "1234")
        .environmentObject(NavigationState())
}
