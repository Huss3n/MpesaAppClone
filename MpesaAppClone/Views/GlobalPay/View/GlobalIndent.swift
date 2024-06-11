//
//  GlobalIndent.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 08/06/2024.
//

import SwiftUI

struct GlobalIndent: View {
    @Binding var humbuger: Bool
    var changeColor: () -> ()
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("View more transactions")
            Rectangle()
                .frame(height: 1)
            
            Text("Change card color")
                .onTapGesture {
                    humbuger.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        changeColor()
                    }
                }
            Rectangle()
                .frame(height: 1)
            
            
            Link("FAQS", destination: URL(string: "https://www.safaricom.co.ke/")!)
                .foregroundStyle(.primary)
            Rectangle()
                .frame(height: 1)
            
            Text("Raise a dispute")
            Rectangle()
                .frame(height: 1)
            
            Text("Cancel Card")
            Rectangle()
                .frame(height: 1)
            
            Text("Opt Out")
            Rectangle()
                .frame(height: 1)
            
            Text("Close")
                .onTapGesture {
                    humbuger.toggle()
                }
        }
        .font(.headline)
        .fontWeight(.light)
    }
}
#Preview {
    GlobalIndent(humbuger: .constant(true), changeColor: {})
}
