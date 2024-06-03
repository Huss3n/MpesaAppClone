//
//  Global.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 31/05/2024.
//

import SwiftUI

struct Global: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var optOut: Bool = false
    @State private var sendToMobile: Bool = false
    @State private var sendToBank: Bool = false
    @State private var sendWesternUnion: Bool = false
    
    // grid columns
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 20) {
                    topButtons
                    
                    Text("GLOBAL")
                        .font(.title)
                        .fontWeight(.light)
                    
                    LazyVGrid(columns: columns) {
                        
                        GlobalComponent (
                            title: "send to mobile",
                            backgroundColor: .blue,
                            icon: "iphone",
                            isSystemImage: true
                        )
                        .onTapGesture {
                            sendToMobile.toggle()
                        }
                        
                        GlobalComponent (
                            title: "send to bank",
                            backgroundColor: .green,
                            icon: "house.and.flag.fill",
                            isSystemImage: true
                        )
                        .onTapGesture {
                            sendToBank.toggle()
                        }
                        
                        GlobalComponent (
                            title: "send to western union",
                            backgroundColor: .yellow,
                            icon: "western-union",
                            isSystemImage: false
                        )
                        .onTapGesture {
                            sendWesternUnion.toggle()
                        }
                        
                        Link(destination: URL(string: "https://www.paypal.com/ke/home")!, label: {
                            GlobalComponent (
                                title: "link paypal account",
                                backgroundColor: .cyan.opacity(0.8),
                                icon: "paypal",
                                isSystemImage: false
                            )
                        })
                        .tint(.primary)
                        
                        Link(destination: URL(string: "https://www.paypal.com/ke/home")!, label: {
                            GlobalComponent (
                                title: "paypal withdraw",
                                backgroundColor: .cyan.opacity(0.8),
                                icon: "paypal",
                                isSystemImage: false
                            )
                        })
                        .tint(.primary)
                       
                        Link(destination: URL(string: "https://www.paypal.com/ke/home")!, label: {
                            GlobalComponent (
                                title: "paypal top up",
                                backgroundColor: .cyan.opacity(0.8),
                                icon: "paypal",
                                isSystemImage: false
                            )
                        })
                        .tint(.primary)
                        
                        GlobalComponent (
                            title: "cost estimator",
                            backgroundColor: .green,
                            icon: "plus.forwardslash.minus",
                            isSystemImage: true
                        )
                        
                        GlobalComponent (
                            title: "roaming pick-up",
                            backgroundColor: .red,
                            icon: "globe",
                            isSystemImage: true
                        )
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 20)
                .sheet(isPresented: $sendToMobile, content: {
                    SendToMobile()
                })
                .sheet(isPresented: $sendToBank, content: {
                    SendToBank(bankOrWesternUnion: true)
                })
                .sheet(isPresented: $sendWesternUnion, content: {
                    SendToBank(bankOrWesternUnion: false)
                })

                if optOut {
                    optOutDialog
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                }
            }
        }
    }
}

#Preview {
//    GlobalComponent(title: "Send to mobile" ,backgroundColor: .green, icon: "paypal", isSystemImage: false)
    Global()
}

struct GlobalComponent: View {
    var title: String
    var backgroundColor: Color
    var icon: String
    var isSystemImage: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
            
            if isSystemImage {
                Image(systemName: icon)
                    .foregroundStyle(backgroundColor)
                    .font(.headline)
                    .padding(8)
                    .background(.white)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    
            } else {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding(8)
                    .background(.white)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .padding(.horizontal)
        .frame(height: 110)
        .padding(.leading, -10)
        .padding(.trailing, -10)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}


extension Global {
    private var topButtons: some View {
        HStack {
            Image(systemName: "xmark")
                .onTapGesture {
                    dismiss()
                }
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .onTapGesture {
                    withAnimation(.easeIn) {
                        optOut.toggle()
                    }
                }
        }
        .imageScale(.large)
    }
    
    
    private var optOutDialog: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(colorScheme == .light ? .black.opacity(0.1) : .gray.opacity(0.15))
            .shadow(radius: 4)
            .frame(height: 130)
            .overlay {
                VStack(spacing: 20) {
                    Text("OPT-OUT")
                        .foregroundStyle(.gray)
                        .font(.headline)
                        .fontWeight(.bold)
                        .onTapGesture {
                            dismiss()
                        }
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 0.5)
                    Text("CANCEL")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .onTapGesture {
                            withAnimation(.default) {
                                optOut.toggle()
                            }
                        }
                }
            }
            .padding(.horizontal, 6)
    }
}
