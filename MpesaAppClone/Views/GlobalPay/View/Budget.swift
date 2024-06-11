//
//  Budget.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 08/06/2024.
//

import SwiftUI

struct Budget: View {
    @ObservedObject var globalVM: GlobalVM
    @FocusState var keyboard: Bool
    @State private var amount: Double = 0
    @Binding var budget: Bool
    
    var body: some View {
        VStack {
            Text("Set up monthly budget")
                .padding(.bottom, 120)
            
            VStack {
                Text("Ksh")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
                TextField("", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($keyboard)
                    .offset(x: 175)
            }
            .frame(maxWidth: .infinity, alignment: .center)
               
            Rectangle()
                .fill(Color.gray)
                .frame(height: 2)
            
            HStack {
                Text("Submit")
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
                    .fill(amount != 10 ? .black.opacity(0.3) : .green)
                    .frame(height: 45)
            )
            .padding(.top, 60)
            .onTapGesture {
                globalVM.updateBudgetAmount(amount: amount)
                budget.toggle()
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            keyboard.toggle()
        }
    }
}

#Preview {
    Budget(globalVM: GlobalVM(), budget: .constant(true))
}
