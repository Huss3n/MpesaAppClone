//
//  MonthlyBudget.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 08/06/2024.
//

import SwiftUI

struct MonthlyBudget: View {
    @ObservedObject var globalVM: GlobalVM
    @Environment(\.dismiss) var dismiss
    var editBudget: () -> ()
    var disableGlobalPay: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("MONTHLY BUDGET")
                .foregroundStyle(.gray)
                .fontWeight(.light)
            
            HStack(spacing: 20)  {
                Image(systemName: "pencil")
                    .font(.title3.bold())
                    .foregroundStyle(.blue)
                
                Text("EDIT")
                    .font(.headline)
                    .onTapGesture {
                        dismiss()
                        editBudget()
                    }
            }
            HStack(spacing: 20) {
                Image(systemName: "xmark")
                    .font(.title3.bold())
                    .foregroundStyle(.red)
                
                Text("DISABLE")
                    .font(.headline)
                    .onTapGesture {
                        disableGlobalPay()
                    }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 32)
        
    }
}

#Preview {
    MonthlyBudget(globalVM: GlobalVM(), editBudget: {}, disableGlobalPay: {})
}
