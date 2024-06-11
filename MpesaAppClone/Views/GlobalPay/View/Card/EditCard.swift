//
//  EditCard.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI

struct EditCard: View {
    @Namespace var namespace
    @ObservedObject var globalVM = GlobalVM()
    var tabSelections: [String] = ["Color", "Image"]
    @Binding var degree: Double
    @State private var selected: String = "Color"
    @State private var callUpdateImage: Bool = false
    
    @Binding var changeColor: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("GlobalPay")
                    .font(.headline.bold())
                
                Spacer()
                
                Image(systemName: "xmark.circle")
                    .onTapGesture {
                        changeColor.toggle()
                    }
            }
            .padding(.top, 20)
            
            Text("We're almost there, take a minute to customize your card. Choose a color or change image for your card")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            CardFront(globalVM: globalVM, degree: $degree)
                .padding()
            
            HStack {
                ForEach(tabSelections, id: \.self) { tabSelection in
                    ZStack(alignment: .bottom) {
                        if selected == tabSelection {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundStyle(.green)
                                .matchedGeometryEffect(id: "tab", in: namespace)
                                .frame(width: 80, height: 4)
                                .offset(y: 8)
                        }
                        
                        Text(tabSelection)
                            .fontWeight(.semibold)
                            .font(.title3)
                            .foregroundStyle(selected == tabSelection ? .green : .black)
                            .background(
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: 80, height: 20)
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding()
                    .onTapGesture {
                        withAnimation(.spring) {
                            selected = tabSelection
                            globalVM.imageOrColor = selected == "Color"
                        }
                    }
                }
            }
                ScrollView(.horizontal) {
                  Chooser(globalVM: globalVM, showImages: selected == "Color")
                }
                .frame(maxWidth: .infinity)
                .scrollIndicators(.hidden)
            
            Spacer()
            
            HStack {
                Text("Update Card")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onTapGesture {
                        changeColor.toggle()
                    }
                
                Image(systemName: "arrow.right")
                    .imageScale(.large)
            }
            .foregroundStyle(.white)
            .padding(.trailing)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.black)
                    .frame(height: 55)
            )
            .offset(y: -40)
        }
        .padding(.horizontal)
        .preferredColorScheme(.light)
    }
}

#Preview {
    EditCard(globalVM: GlobalVM(), degree: .constant(0.0), changeColor: .constant(true))
}
