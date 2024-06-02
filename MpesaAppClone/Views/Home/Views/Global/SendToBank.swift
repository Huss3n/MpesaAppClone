//
//  SendToBank.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 01/06/2024.
//

import SwiftUI

struct SendToBank: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var countriesFetch = CountriesFetch.shared
    @State private var selectedCountry: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
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
                
                Text("SEND TO BANK")
                    .font(.title)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(AllCountries.shared.allCountries, id: \.self) { country in
                    AllCountriesComponent(
                        countryName: country,
                        flagURL: country,
                        countryCurrency: ""
                    )
                }
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SendToBank()
}

struct AllCountriesComponent: View {
    var countryName: String
    var flagURL: String
    var countryCurrency: String
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(.clear)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(flagURL)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(Color.black, lineWidth: 0.4)
                        }
                }
            
            VStack(alignment: .leading) {
                Text(countryName.uppercased())
                    .foregroundStyle(.primary)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Text(countryCurrency)
                    .foregroundStyle(.gray)
            }
        }
    }
}
