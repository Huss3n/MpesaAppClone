//
//  Statements.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 29/05/2024.
//

import SwiftUI

struct Statements: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var searchTransaction: String = ""
    @State private var showSearchText: Bool = false
    @FocusState var keyboard: Bool
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(systemName: "arrow.left")
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            VStack {
                                if showSearchText {
                                    Text("cancel")
                                } else {
                                    Image(systemName: "magnifyingglass")
                                }
                            }
                            .frame(width: 50, height: 30)
//                            .background(.red)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    showSearchText.toggle()
                                }
                                keyboard = true
                            }
                        }
                    }
                }
                
                VStack {
                    if showSearchText {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray.opacity(0.3))
                            .frame(width: 250, height: 35)
                            .overlay {
                                TextField("Search", text: $searchTransaction)
                                    .padding(.leading)
                                    .focused($keyboard)
                            }
                            .offset(y: -8)
                        
                    } else {
                        Text("M-PESA STATEMENTS")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .offset(y: -30)
                
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(colorScheme == .light ? Color.black.opacity(0.8) : Color.gray.opacity(0.3) )
                    .frame(width: 250, height: 60)
                    .overlay {
                        HStack {
                            Image(systemName: "doc")
                                .imageScale(.large)
                            
                            Text("EXPORT STATEMENTS")
                        }
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(.green)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()
                    .opacity(showSearchText ? 0 : 1)
            }
        }
    }
}

#Preview {
    Statements()
}
