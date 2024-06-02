//
//  SendToMobile.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 01/06/2024.
//

import SwiftUI
import SDWebImageSwiftUI


struct SendToMobile: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var countriesFetch = CountriesFetch.shared
    @State private var showManuallView: Bool = false
    @State private var selectedCountry: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
                
                Text("SEND TO MOBILE")
                    .font(.title)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(countriesFetch.fetchedSend) { cou in
                        CountryComponent(
                            countryName: cou.name.common,
                            countryCode: "\(cou.idd.root) \(cou.idd.suffixes.first!)",
                            flagURL: cou.flags.png,
                            countryCurrency: "",
                            showCurrency: false
                        )
                        .onTapGesture {
                            self.selectedCountry = cou.name.common
                            showManuallView.toggle()
                        }
                }
                
            }
            .sheet(isPresented: $showManuallView, content: {
                ContactEntryCountry(title: $selectedCountry)
            })
            .padding(.horizontal, 8)
            .onAppear {
                Task.init {
                    try await CountriesFetch.shared.fetchSendCountries()
                }
            }
        }
    }
}

#Preview {
    SendToMobile()
}


struct CountryComponent: View {
    var countryName: String
    var countryCode: String
    var flagURL: String
    var countryCurrency: String
    
    var showCurrency: Bool = false
    
    // Computed property to format the country code
      private var formattedCountryCode: String {
          // Split the country code into root and suffixes
          let parts = countryCode.split(separator: " ")
          if parts.count == 2 {
              // Join the suffixes and append them to the root
              return "\(parts[0])\(parts[1].replacingOccurrences(of: "[\"\\]", with: " ", options: .regularExpression))"
          } else {
              // Return original code if it doesn't match expected format
              return countryCode
          }
      }
    
    var body: some View {
        HStack {
            Circle()
                .fill(.clear)
                .frame(width: 50, height: 50)
                .overlay {
                    if showCurrency {
                        Image(flagURL)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color.black, lineWidth: 0.4)
                            }
                    } else {
                        WebImage(url: URL(string: flagURL)!)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color.black, lineWidth: 0.4)
                            }
                    }
                }
            
            VStack(alignment: .leading) {
                Text(countryName)
                    .foregroundStyle(.primary)
                    .font(.headline)
                    .fontWeight(.medium)
                
                
                if showCurrency {
                    Text(countryCurrency)
                        .foregroundStyle(.gray)
                } else {
                    Text(formattedCountryCode)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}
