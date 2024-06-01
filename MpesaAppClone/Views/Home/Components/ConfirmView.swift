//
//  ConfirmView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 30/05/2024.
//

import SwiftUI

struct ConfirmView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    // what to receive
    var sendOrRequest: SendOrRequest = .send
    var phoneNumber: String = "070000000"
    var amount: Double = 0
    var contact: Contact?
    
    // compute transaction cost
    var transactionCost: Double {
        if amount < 49 && amount <= 100 {
            return 0.0
        } else if amount > 100 && amount <= 500 {
            return 7
        } else if amount > 500 && amount <= 1000 {
            return 13
        } else if amount > 1000 && amount <= 1500 {
            return 23
        } else if amount > 1500 && amount <= 2500 {
            return 33
        } else if amount > 2500 && amount <= 3500 {
            return 53
        } else if amount > 3500 && amount <= 5000 {
            return 57
        } else if amount > 5000 && amount <= 7500 {
            return 78
        } else if amount > 7500 && amount <= 10_000 {
            return 90
        } else if amount > 10_000 && amount <= 15_000 {
            return 100
        } else if amount > 15_000 && amount <= 20_000 {
            return 105
        }
        return 0.0
    }
    
    var contactToShow: String {
        if phoneNumber.isEmpty {
            return contact?.mobileNumber ?? phoneNumber
        } else {
            return phoneNumber
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
                    .frame(height: 480)
                    .overlay {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(sendOrRequest == .send ? "SEND MONEY" : "REQUEST MONEY")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(colorScheme == .light ? .black.opacity(0.4) : .white.opacity(0.05))
                                .cornerRadius(25)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .offset(y: -20)
                            
                            // add the image from the contact and name here
                            if !phoneNumber.isEmpty {
                                Circle()
                                    .fill(.gray.opacity(0.3))
                                    .frame(width:80, height: 80)
                                    .overlay {
                                        Image(systemName: "person")
                                            .font(.largeTitle)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .offset(y: -10)
                            } else {
                                // show contact info
                                Circle()
                                    .fill(.gray.opacity(0.3))
                                    .frame(width: 100, height: 100)
                                    .overlay {
                                        Text(contact?.initials ?? "")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .offset(y: -30)
                            }
                            
                            if contact != nil {
                                Text(sendOrRequest == .send ? "SEND TO" : "REQUEST FROM")
                                    .foregroundStyle(.gray)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                
                                Text("\(contact?.givenName ?? "") \(contact?.familyName ?? "")")
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 12)
                            }
                            
                            Text("PHONE NUMBER")
                                .foregroundStyle(.gray)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 8)
                            
                            Text(contactToShow)
                                .padding(.horizontal, 8)
                                .padding(.bottom, 12)
                            
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
                            
                            HStack {
                                Text("ADD DESCRIPTION")
                                    .foregroundStyle(.gray)
                                    .fontWeight(.light)
                                
                                Spacer()
                                
                                Text("ADD GIF")
                                    .font(.caption)
                                    .foregroundStyle(.primary)
                                    .padding(8)
                                    .background(
                                        Capsule()
                                            .stroke(.primary, lineWidth: 1.0)
                                    )
                                    .cornerRadius(20)
                            }
                            .padding(.horizontal, 8)
                            .offset(y: 5)
                        }
                        .padding(.horizontal, 4)
                        
                    }
            }
            .padding(.top, 50)
            
            HStack {
                Text("Send".uppercased())
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
                // call face id auth
                
                // if successfull call func to detuct mpesa balance
                // update user default balance and firebase balance
                // send notification with the transaction
            }
            
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    ConfirmView()
}
