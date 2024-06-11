//
//  TransactionCatgory.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 09/06/2024.
//

import SwiftUI

struct TransactionCatgory: View {
    @Binding var categoryName: String
    @Binding var categoryColor: Color
    @Binding var dismissCat: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Transaction category".uppercased())
                    .font(.title3)
                    .fontWeight(.light)
                
                TransactionCatgoryComponent(
                    name: "Shopping",
                    imageName: "basket",
                    backgroundColor: .blue.opacity(0.8)
                )
                .onTapGesture {
                    self.categoryName = "Shopping"
                    self.categoryColor = .blue.opacity(0.8)
                    dismissCat.toggle()
                }
                
                TransactionCatgoryComponent(
                    name: "food and beverage",
                    imageName: "fork.knife",
                    backgroundColor: .green.opacity(0.8)
                )
                .onTapGesture {
                    self.categoryName = "food and beverage"
                    self.categoryColor = .green.opacity(0.8)
                    dismissCat.toggle()
                }
                
                TransactionCatgoryComponent(
                    name: "entertainment",
                    imageName: "music.note.tv",
                    backgroundColor: .cyan.opacity(0.8)
                )
                .onTapGesture {
                    self.categoryName = "entertainment"
                    self.categoryColor = .cyan.opacity(0.8)
                    dismissCat.toggle()
                }
                
                TransactionCatgoryComponent(
                    name: "transport and travel",
                    imageName: "bus",
                    backgroundColor: .purple
                )
                .onTapGesture {
                    self.categoryName = "transport and travel"
                    self.categoryColor = .purple
                    dismissCat.toggle()
                }
                
                TransactionCatgoryComponent(
                    name: "bills and services",
                    imageName: "house",
                    backgroundColor: .pink
                )
                .onTapGesture {
                    self.categoryName = "bills and services"
                    self.categoryColor = .pink
                    dismissCat.toggle()
                }
                
                TransactionCatgoryComponent(
                    name: "education",
                    imageName: "graduationcap",
                    backgroundColor: .yellow
                )
                .onTapGesture {
                    self.categoryName = "education"
                    self.categoryColor = .yellow
                    dismissCat.toggle()
                }
                
                TransactionCatgoryComponent(
                    name: "county government",
                    imageName: "building.columns",
                    backgroundColor: .orange
                )
                .onTapGesture {
                    self.categoryName = "county government"
                    self.categoryColor = .orange
                    dismissCat.toggle()
                }
                
                TransactionCatgoryComponent(
                    name: "withdrawal",
                    imageName: "banknote",
                    backgroundColor: .indigo
                )
                
                TransactionCatgoryComponent(
                    name: "loans and savings",
                    imageName: "magsafe.batterypack",
                    backgroundColor: .mint
                )
                
                TransactionCatgoryComponent(
                    name: "family and friends",
                    imageName: "person",
                    backgroundColor: .teal
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 32)
        }
    }
}

#Preview {
    TransactionCatgory(categoryName: .constant("Name"), categoryColor: .constant(.gray), dismissCat: .constant(true))
    //    TransactionCatgoryComponent(name: "Shopping", imageName: "basket", backgroundColor: .blue)
}


struct TransactionCatgoryComponent: View {
    var name: String
    var imageName: String
    var backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: imageName)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .padding(10)
                    .background(backgroundColor)
                    .clipShape(Circle())
                
                Text(name.uppercased())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
            }
        }
        
    }
}
