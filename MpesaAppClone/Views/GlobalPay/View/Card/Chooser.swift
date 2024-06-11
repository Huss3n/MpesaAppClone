//
//  Chooser.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 06/06/2024.
//

import SwiftUI

struct Chooser: View {
    @ObservedObject var globalVM: GlobalVM
    var showImages: Bool
    var width: CGFloat = 240
    var height: CGFloat = 130
    var imageUsed: String? = nil
    var colorUsed: Color? = nil
    
    
    var body: some View {
        if showImages {
            HStack {
                ForEach(globalVM.cardColors, id: \.self) { color in
                    ZStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("M-PESA")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            
                            
                            HStack(alignment: .center, spacing: 20) {
                                Text("1234")
                                Text("****")
                                Text("****")
                                Text("****")
                            }
                            .foregroundStyle(.white)
                            
                            Image("visa")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                                .offset(y: -5)
                        }
                        .padding(.horizontal)
                        .frame(width: width, height: height)
                        .background(colorUsed ?? Color(color) )
                        .cornerRadius(10)
                        .onTapGesture {
                            globalVM.updateBackgroundColor(newColor: color)
                        }
                        
                        if globalVM.backgroundColor == color {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(x: width / 2 - 24, y: -height / 2 + 24)
                        }
                    }
                }
            }
        } else {
            HStack {
                ForEach(globalVM.cardImages, id: \.self) { image in
                    ZStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("M-PESA")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                                .padding(.top, 20)
                            
                            HStack(alignment: .center, spacing: 20) {
                                Text("1234")
                                Text("****")
                                Text("****")
                                Text("****")
                            }
                            .foregroundStyle(.white)
                            Image("visa")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                                .offset(y: -5)
                        }
                        .padding(.horizontal)
                        .frame(width: width, height: height)
                        .background(
                            Image(imageUsed ?? image)
                                .resizable()
                        )
                        .cornerRadius(10)
                        .onTapGesture {
                            globalVM.updateBackgroundImage(newImage: image)
                            
                        }
                        
                        if globalVM.backgroundSelected == image {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(x: width / 2 - 24, y: -height / 2 + 24)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Chooser(globalVM: GlobalVM(), showImages: (true))
}
