//
//  CardBack.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI
struct CardBack: View {
    @ObservedObject var globalVM = GlobalVM()
    @Binding var degree: Double

    var body: some View {
        if globalVM.imageOrColor {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Card number")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    
                    HStack(alignment: .center, spacing: 20) {
                        HStack {
                            Text("1234")
                            Text("0000")
                            Text("0000")
                            Text("0000")
                        }
                        .padding(.trailing, 32)
                        .font(.subheadline)
                        
                        HStack {
                            Image(systemName: "doc.on.clipboard")
                            Text("Copy")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 30)
                        .background(.black)
                        .cornerRadius(10)
                    }
                    .foregroundStyle(.black)
                    .frame(width: 330, height: 50)
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding(.bottom, 32)
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expiry(mmyy")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        HStack(alignment: .center, spacing: 20) {
                            HStack {
                                Text("06/27")
                                    .font(.subheadline)
                            }
                            .padding(.trailing, 32)
                        }
                        .foregroundStyle(.black)
                        .frame(width: 120, height: 40)
                        .background(.white)
                        .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CVV")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        HStack(alignment: .center, spacing: 20) {
                            HStack {
                                Text("412")
                                    .font(.subheadline)
                            }
                            .padding(.trailing, 32)
                        }
                        .foregroundStyle(.black)
                        .frame(width: 120, height: 40)
                        .background(.white)
                        .cornerRadius(10)
                    }
                    .padding(.trailing, 32)
                }
            }
            .padding(.horizontal)
            .frame(width: 350, height: 220)
            .background( Color(globalVM.backgroundColor.isEmpty ? globalVM.starterColor : globalVM.backgroundColor ))
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(
                    degrees: degree
                ),
                axis: (
                    x: 0.0,
                    y: 1.0,
                    z: 0.0
                )
            )
            
        } else {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Card number")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    
                    HStack(alignment: .center, spacing: 20) {
                        HStack {
                            Text("1234")
                            Text("0000")
                            Text("0000")
                            Text("0000")
                        }
                        .padding(.trailing, 32)
                        .font(.subheadline)
                        
                        HStack {
                            Image(systemName: "doc.on.clipboard")
                            Text("Copy")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 30)
                        .background(.black)
                        .cornerRadius(10)
                    }
                    .foregroundStyle(.black)
                    .frame(width: 330, height: 50)
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding(.bottom, 32)
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expiry(mmyy")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        HStack(alignment: .center, spacing: 20) {
                            HStack {
                                Text("06/27")
                                    .font(.subheadline)
                            }
                            .padding(.trailing, 32)
                        }
                        .foregroundStyle(.black)
                        .frame(width: 120, height: 40)
                        .background(.white)
                        .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CVV")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        HStack(alignment: .center, spacing: 20) {
                            HStack {
                                Text("412")
                                    .font(.subheadline)
                            }
                            .padding(.trailing, 32)
                        }
                        .foregroundStyle(.black)
                        .frame(width: 120, height: 40)
                        .background(.white)
                        .cornerRadius(10)
                    }
                    .padding(.trailing, 32)
                }
            }
            .padding(.horizontal)
            .frame(width: 350, height: 220)
            .background(
                Image(globalVM.backgroundSelected.isEmpty ? globalVM.starterBackground : globalVM.backgroundSelected)
                    .resizable()
            )
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(
                    degrees: degree
                ),
                axis: (
                    x: 0.0,
                    y: 1.0,
                    z: 0.0
                )
            )
        }
    }
}

#Preview {
    CardBack(degree: .constant(0.0))
}

