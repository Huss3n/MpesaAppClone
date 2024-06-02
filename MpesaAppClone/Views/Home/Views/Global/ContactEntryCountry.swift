//
//  ContactEntryCountry.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 01/06/2024.
//

import SwiftUI

struct ContactEntryCountry: View {
    @Environment(\.dismiss) var dismiss
    @State private var search: String = ""
    @State private var manuallyButton: Bool = false
    
    @Binding var title: String
    
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "arrow.left")
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
            
            
            Text("SEND TO \(title)".uppercased())
                .font(.title)
                .fontWeight(.light)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
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
                    
                    HStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "keyboard.chevron.compact.down")
                                    .foregroundStyle(.white)
                            }
                        
                        Text("ENTER MANUALLY")
                            .font(.headline)
                            .foregroundStyle(.blue)
                            .onTapGesture {
                                manuallyButton.toggle()
                            }
                    }
                    
                    Text("CONTACTS")
                        .font(.headline)
                        .fontWeight(.medium)
                    
                    VStack(spacing: 10) {
                        Image(systemName: "person.text.rectangle")
                            .font(.system(size: 60))
                            .fontWeight(.light)
                        
                        Text("No contacts found")
                            .font(.headline)
                        
                        VStack(spacing: 4) {
                            Text("You dont have any contacts from")
                            Text("\(title) on your contact list")
                        }
                        .fontWeight(.light)

                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 42)
                    
                }
            }
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $manuallyButton) {
            NumericPad(sendOrRequest: .send)
        }
    }
}

#Preview {
    ContactEntryCountry(title: .constant("Tanzania"))
}
