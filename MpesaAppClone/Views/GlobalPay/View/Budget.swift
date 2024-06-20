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
    
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                Spacer()
                Text("Set up monthly budget")
                    .padding(.top, 30)
                
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
                
                Text("Amount cannot be less than 100")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .opacity(showError ? 1 : 0)
                    .onChange(of: amount) {
                        if amount > 0 {
                            showError.toggle()
                        }
                    }
                
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
                    guard amount >= 100 else {
                        showError.toggle()
                        return
                    }
                    
                    globalVM.updateBudgetAmount(amount: amount)
                    budget.toggle()
                }
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                keyboard.toggle()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            budget.toggle()
                        }
                }
            }
        }
    }
}

#Preview {
    Budget(globalVM: GlobalVM(), budget: .constant(true))
}
