//
//  SettingsTop.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI

struct SettingsTop: View {
    @Environment(\.dismiss) var dismiss
    @Binding var settings: Bool
    @Binding var safariView: Bool
    var callToAction: () -> (Void)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image("slogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("M-Shwari >")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            HStack(spacing: 30) {
                VStack(alignment: .center, spacing: 14) {
                    Image(systemName: "gear")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        .padding(8)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 1.5)
                    Text("Setting")
                }
                
                VStack(alignment: .center, spacing: 14) {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        .padding(8)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 1.5)
                        .onTapGesture {
                            settings.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                safariView.toggle()
                            }
                        }
                    Text("About")
                    
                }
                
                VStack(alignment: .center, spacing: 14) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        .padding(8)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 1.5)
                        .onTapGesture {
                            callToAction()
                        }
                    Text("Reopen")
                }
            }
            .padding(.horizontal)
            
            Text("Cancel")
                .foregroundStyle(.black)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.white)
                .clipShape(Rectangle())
                .shadow(radius: 1)
                .onTapGesture {
                    dismiss()
                }
        }
        .padding(.top, 32)
        .padding(.bottom, 32)
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
    SettingsTop(settings: .constant(true), safariView: .constant(true), callToAction: {})
}
