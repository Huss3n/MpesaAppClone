//
//  SuspendCard.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 08/06/2024.
//

import SwiftUI

struct SuspendCard: View {
    var backToGlobal: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("SUSPEND CARD")
                .fontWeight(.light)
            
            Text("This service temporarilty disables your card. You will not be able to make global payments including repet payments using the current card details unless you unsuspend your card. Do you want to continue?")
                .multilineTextAlignment(.leading)
                .fontWeight(.light)
            
            HStack(spacing: 20) {
                Text("Back")
                    .padding(10)
                    .padding(.horizontal, 30)
                    .background(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 4)
                
                
                Text("SUSPEND")
                    .padding(10)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 30)
                    .background(.red)
                    .clipShape(Capsule())
                    .shadow(radius: 4)
                    .onTapGesture {
                        backToGlobal()
                    }
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 32)
    }
}

#Preview {
    SuspendCard(backToGlobal: {})
}
