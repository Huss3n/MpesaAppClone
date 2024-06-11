//
//  FundsOriginPath.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI

struct FundsOriginPath: View {
    @Environment(\.dismiss) var dismiss
    @State private var origin: FundsOrigin = .mpesa
    @State var reqPay: ReqPayPath = .pay
    @State private var navigate: Bool = false
    @State private var isMpesa: Bool = false
    
    var amount: Double
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Image(systemName: "arrow.left")
                    .font(.title3)
                    .padding(.top, 20)
                    .onTapGesture {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("PAY LOAN")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.top, 40)
                
                Text("CHOOSE FUNDS ORIGIN")
                    .font(.subheadline)
                    .fontWeight(.light)
                
                VStack (spacing: 20){
                    HStack {
                        Image("airtime")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.green)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color.green, lineWidth: 1.0)
                                    .frame(width: 50, height: 50)
                            }
                        
                        Text("M-PESA")
                            .font(.subheadline)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Image(systemName: "greaterthan")
                    }
                    .padding(10)
                    .background(.white)
                    .cornerRadius(6)
                    .shadow(radius: 2)
                    .onTapGesture {
                        isMpesa = true
                        navigate.toggle()
                        self.origin = .mpesa
                    }
                    
                    
                    HStack {
                        Image("slogo")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.green)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("M-SHWARI")
                            .font(.subheadline)
                            .fontWeight(.light)
                        
                        Spacer()
                        Image(systemName: "greaterthan")
                    }
                    .padding(10)
                    .background(.white)
                    .cornerRadius(6)
                    .shadow(radius: 2)
                    .onTapGesture {
                        isMpesa = false
                        navigate.toggle()
                        self.origin = .mshwari
                    }
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $navigate) {
                ConfirmReqPay(reqPayPath: reqPay, loanAmount: amount, isMpesa: isMpesa)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    FundsOriginPath(amount: 0)
}
