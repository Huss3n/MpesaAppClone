//
//  RepeatPayments.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 08/06/2024.
//

import SwiftUI

struct RepeatPayments: View {
    @Binding var showRepeatPayments: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Repeat Payments")
                .padding(.bottom, 80)
            
            Image("atm")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("This service allows merchants you have previously authorixed to take payments from GlobalPay for goofs and services based on a prearranged schedule")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
            
            HStack {
                Text("ENABLE")
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
                    .fill(.black)
                    .frame(height: 45)
            )
            .padding(.top, 40)
            .onTapGesture {
                showRepeatPayments.toggle()
            }
            
            VStack(spacing: 10) {
                Text("Learn more about repeat")
                HStack {
                    Text("payments")
                    Link("here", destination: URL(string: "https://www.safaricom.co.ke/")!)
                        .tint(.black)
                        .foregroundStyle(.black)
                }
            }
            .foregroundStyle(.gray)
        }
        .padding(.horizontal, 20)
        .preferredColorScheme(.light)
    }
}

#Preview {
    RepeatPayments(showRepeatPayments: .constant(true))
}
