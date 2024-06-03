//
//  BuyGoods.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 02/06/2024.
//

import SwiftUI

struct BuyGoods: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var search: String = ""
    @State private var enterTillNumber: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray)
                            .frame(width: 60, height: 6)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.green)
                            .frame(width: 14, height: 6, alignment: .leading)
                            .offset(x: -23)
                    }
                }
                .padding(.top, 20)
                
                
                Text("BUY GOODS")
                    .font(.title)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                    
                    
                    TextField("Search Contacts", text: $search)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.gray.opacity(0.3))
                )
                
                VStack {
                    Circle()
                        .fill(colorScheme == .light ? Color.blue.opacity(0.1) : .white)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundStyle(.blue)
                        }
                    
                    Text("Add Favourite")
                }
                
                HStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .foregroundStyle(.white)
                        }
                    
                    Text("ENTER TILL NUMBER")
                        .font(.headline)
                        .foregroundStyle(.blue)
                        .onTapGesture {
                            enterTillNumber.toggle()
                        }
                }
                
                HStack {
                    Circle()
                        .fill(.cyan)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "qrcode")
                                .foregroundStyle(.white)
                        }
                    
                    Text("SCAN QR CODE")
                        .font(.headline)
                }
                
                Text("FREQUENTS")
                Frequents(circleName: "NS", name: "Naivas Supermarket")
                Frequents(circleName: "RP", name: "Rubis Petrol Station")
                Frequents(circleName: "QM", name: "Quick Mart")
                Frequents(circleName: "TS", name: "Total South C")
                Frequents(circleName: "CL", name: "Caffe Light")
            }
            .padding(.horizontal)
            .sheet(isPresented: $enterTillNumber, content: {
                BuyGoodsNumberPad(title: "BUY GOODS", placeholder: "till")
            })
        }
    }
}

#Preview {
    BuyGoods()
}

struct Frequents: View {
    var circleName: String
    var name: String

    var body: some View {
        HStack {
            Circle()
                .fill(.gray.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay {
                    Text(circleName.uppercased())
                }
            
            Text(name)
        }
    }
}
