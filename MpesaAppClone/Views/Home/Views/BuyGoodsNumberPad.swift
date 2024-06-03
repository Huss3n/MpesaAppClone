//
//  BuyGoodsNumberPad.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 02/06/2024.
//

import SwiftUI

struct BuyGoodsNumberPad: View {
    @Environment(\.dismiss) var dismiss
    @State private var tillNumber: String = ""
    @State private var isTillNumberEmpty: Bool = false
    
    var title: String
    var placeholder: String
    
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
                
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .padding(.top, 10)
//                    .padding(.bottom, 120)
                
                Spacer()
                
                // MARK: Enter till number
                ZStack(alignment: .center) {
                    if tillNumber.isEmpty {
                        Text("Enter \(placeholder) number")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                    }
                    VStack {
                        if !tillNumber.isEmpty {
                            Text("Enter \(placeholder) number")
                                .font(.headline)
                                .fontWeight(.light)
                                .foregroundColor(.green)
                        }
                        
                        TextField("", text: $tillNumber)
                            .font(.title)
                            .fontWeight(.light)
                            .keyboardType(.numberPad)
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                        
                        if tillNumber.count >= 10 {
                            Text("\(placeholder) number is invalid")
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
                        Text("Complete \(title) transaction")
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
                                    .fill(tillNumber.count != 10 ? .black.opacity(0.3) : .green)
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
                                        tillNumber.append("\(row * 3 + column)")
                                    })
                                }
                            }
                        }
                        HStack(spacing: 30) {
                            NumberButton(number: "", action: {}) // Placeholder for alignment
                            NumberButton(number: "0", action: {
                                tillNumber.append("0")
                            })
                            NumberButton(number: "X", action: {
                                if !tillNumber.isEmpty {
                                    tillNumber.removeLast()
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
    BuyGoodsNumberPad(title: "BUY GOODS", placeholder: "Till")
}
