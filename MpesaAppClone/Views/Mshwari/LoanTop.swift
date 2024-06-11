//
//  LoanTop.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI
struct LoanTop: View {
    @Environment(\.dismiss) var dismiss
    @Binding var loan: Bool
    @Binding var reqPay: ReqPayPath
    @Binding var navigate: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("LOAN")
                .font(.headline)
                .padding(.horizontal)
            
            HStack(spacing: 14) {
                Image("request")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text("REQUEST LOAN")
            }
            .padding(.horizontal)
            .onTapGesture {
                loan.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    reqPay = .loan
                    navigate.toggle()
                }
            }
            
            HStack(spacing: 14) {
                Image("payLoan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text("PAY LOAN")
            }
            .padding(.horizontal)
            .onTapGesture {
                loan.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    reqPay = .pay
                    navigate.toggle()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .background(.gray.opacity(0.1))
        .clipShape(
            .rect(
                topLeadingRadius: 20,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 20
            )
        )
    }
}

#Preview {
    LoanTop(loan: .constant(true), reqPay: .constant(.loan), navigate: .constant(true))
}
