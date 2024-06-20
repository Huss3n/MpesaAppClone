//
//  SendMoneySuccess.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 09/06/2024.
//

import SwiftUI

struct AuthSuccess: View {
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.dismiss) var dismiss
    @State private var category: String = "GENERAL"
    @State private var categoryColor: Color = .orange
    @State private var showCategories: Bool = false
    var name: String = "Hussein Aisak"
    var phoneNumber: String = "0712 345 678"
    var transactionCost: Double = 0
    var contact: Contact?
    var transactionType: TransactionType
    
    @State private var randomID: String = ""
    
    // withdraw details
    var agentNumber: String = "1234"
    var storeNumber: String = "3456"
    
    // dismiss previous views
    @Binding var cancel: Bool
    @Binding var authSuccess: Bool
    
    var amount: Double = 0
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "xmark")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    authSuccess.toggle()
                }
            
            if transactionType == .sendMoney || transactionType == .airtime {
                // add the image from the contact and name here
                if contact == nil {
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
                    
                    HStack {
                        Text(contact?.givenName.uppercased() ?? "HUSSEIN")
                        Text(contact?.familyName.uppercased() ?? "AISAK")
                    }
                }
            }
            
            if transactionType == .withdraw {
                Circle()
                    .fill(.gray.opacity(0.3))
                    .frame(width:80, height: 80)
                    .overlay {
                        Image(systemName: "building.columns")
                            .font(.title)
                    }
            }
            HStack {
                Text(transactionType == .withdraw ? "AGENT NAME" : "")
                Text(transactionType == .withdraw ? "HELLO WORLD" : "")
                    .fontWeight(.light)
            }
            
            HStack {
                Text(transactionType == .withdraw ? "AGENT NUMBER" : "PHONE NUMBER")
                Text(transactionType == .withdraw ? agentNumber : phoneNumber)
                    .fontWeight(.light)
            }
            
            if transactionType == .withdraw {
                HStack {
                    Text("STORE NUMBER")
                    Text(storeNumber)
                        .fontWeight(.light)
                }
            }
            
            HStack {
                Text("KSH. \(String(format: "%.2f", amount))")
                Text("FEE: KSH. \(String(format: "%.2f", transactionCost))")
                    .fontWeight(.light)
            }
            
            HStack {
                Text(category)
                Image(systemName: "chevron.down")
            }
            .font(.headline)
            .foregroundStyle(categoryColor)
            .padding(12)
            .padding(.horizontal)
            .background(categoryColor.opacity(0.1))
            .clipShape(Capsule())
            .padding(.bottom, 40)
            .onTapGesture {
                showCategories.toggle()
            }
            
            
            CheckMarkAnimation(startAnimation: true)
            
            Text("Your transaction is successful")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.green)
            
            HStack {
                Text("ID: \(randomID)")
                Image(systemName: "doc.on.doc.fill")
            }
            .font(.headline)
            .foregroundStyle(Color("mshwariColor"))
            .padding(10)
            .background(.green.opacity(0.1))
            .clipShape(Capsule())
            .padding(.bottom, 40)
            
            
            VStack {
                Image(systemName: "arrow.counterclockwise")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.gray.opacity(0.6))
                    .clipShape(Circle())
                
                Text("REVERSE")
                Text("TRANSACTION")
            }
            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.green)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .overlay {
                    Text("DONE")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .onTapGesture {
                    navigationState.shouldNavigateToHome = true
                }
            
        }
        .padding(.horizontal)
        .sheet(isPresented: $showCategories, content: {
            TransactionCatgory(categoryName: $category, categoryColor: $categoryColor, dismissCat: $showCategories)
                .presentationDetents([.medium, .large])
        })
        .onAppear {
            self.randomID = RandomID.shared.randomString()
        }
        .onDisappear {
            navigationState.shouldNavigateToHome = false
        }
    }
}

#Preview {
    AuthSuccess(transactionType: .airtime, cancel: .constant(true), authSuccess: .constant(true))
}

