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
    @State private var search: String = ""
    @State private var countryTapped: Bool = false
    
    
    var bankOrWesternUnion: Bool
    
    var filteredCountries: [String] {
        if search.isEmpty {
            return AllCountries.shared.countryCurrencyArray.keys.sorted()
        } else {
            return AllCountries.shared.countryCurrencyArray.keys.filter {
                $0.lowercased().contains(search.lowercased())
            }.sorted()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
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
            
            Text(bankOrWesternUnion ? "SEND TO BANK" : "WESTERN UNION")
                .font(.title)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
                
                
                TextField("Search", text: $search)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.gray.opacity(0.2))
            )
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(filteredCountries, id: \.self) { country in
                        if let currency = AllCountries.shared.countryCurrencyArray[country] {
                            AllCountriesComponent(
                                countryName: country,
                                flagURL: country, // Assuming flagURL is a valid URL
                                countryCurrency: currency
                            )
                            .onTapGesture {
                                countryTapped.toggle()
                            }
                            .sheet(isPresented: $countryTapped, content: {
                                CountyCode(country: country, bankOrWesternUnion: bankOrWesternUnion)
                            })
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    SendToBank(bankOrWesternUnion: true)
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
                    .fontWeight(.light)
            }
        }
    }
}

struct CountyCode: View {
    @Environment(\.dismiss) var dismiss
    @State private var firstName: String = ""
    @State private var middleName: String = ""
    @State private var lastName: String = ""
    @State private var address: String = ""
    
    var country: String
    var bankOrWesternUnion: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 60) {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Spacer()
                    Text(bankOrWesternUnion ? "SEND TO BANK" : "SEND TO WESTERN UNION")
                        .font(bankOrWesternUnion ? .subheadline : .caption)
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
                .font(.headline)
                .padding(.top, 30)
                
                
                VStack(spacing: 8) {
                    TextField("FIRST NAME", text: $firstName)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                }
                
                VStack(spacing: 8) {
                    TextField("MIDDLE NAME OPTIONAL", text: $middleName)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                }
                
                VStack(spacing: 8) {
                    TextField("LAST NAME", text: $lastName)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                }
                
                if bankOrWesternUnion {
                    
                    VStack(spacing: 8) {
                        TextField("ADDRESS", text: $address)
                        Rectangle()
                            .fill(.gray)
                            .frame(height: 2)
                    }
                } else {
                    Text("The recipients name must match the name on the recipients ID document")
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                NavigationLink {
                    BankView(name: firstName + lastName, country: country)
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Continue".uppercased())
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Image(systemName: "arrow.right")
                            .imageScale(.large)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.green)
                            .frame(height: 55)
                    )
                }
                .tint(.primary)
                .padding(.bottom, 32)
                
                
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct BankView: View {
    @Environment(\.dismiss) var dismiss
    @State private var bankNameCount: Int = 0
    @State private var bankCodeCount: Int = 0
    @State private var accountNumberCount: Int = 0
    @State private var branchCodeCount: Int = 0
    @State private var accountSuffixCount: Int = 0
    
    
    @State private var bankName: String = ""
    @State private var bankCode: String = ""
    @State private var accountNumber: String = ""
    @State private var branchCode: String = ""
    @State private var accountSUffix: String = ""
    
    var name: String
    var country: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                
                Spacer()
                Text("SEND TO BANK")
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
            .font(.headline)
            .padding(.top, 30)
            
            VStack {
                Image(systemName: "building.columns")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.green)
                    .clipShape(Circle())
                
                Text("SEND TO BANK")
                    .font(.headline)
                HStack {
                    Text(name.uppercased())
                        .font(.headline)
                    
                    Text(country.uppercased())
                        .fontWeight(.light)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("BANK NAME")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                        .opacity(bankName.isEmpty ? 0 : 1)
                    
                    TextField("BANK NAME OPTIONAL", text: $bankName)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                    Text("\(bankNameCount)/50")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onChange(of: bankName) {
                            bankNameCount = bankName.count
                        }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("BANK CODE")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                        .opacity(bankCode.isEmpty ? 0 : 1)
                    
                    TextField("BANK CODE", text: $bankCode)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                    Text("\(bankCodeCount)/3")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onChange(of: bankCode) {
                            bankCodeCount = bankCode.count
                        }
                }
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("BRANCH CODE")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                        .opacity(branchCode.isEmpty ? 0 : 1)
                    
                    TextField("BRANCH CODE", text: $branchCode)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                    Text("\(branchCodeCount)/3")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onChange(of: branchCode) {
                            branchCodeCount = branchCode.count
                        }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ACCOUNT NUMBER")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                        .opacity(accountNumber.isEmpty ? 0 : 1)
                    
                    TextField("ACCOUNT NUMBER", text: $accountNumber)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                    Text("\(accountNumberCount)/6")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onChange(of: accountNumber) {
                            accountNumberCount = accountNumber.count
                        }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ACCOUNT SUFFIX")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                        .opacity(accountSUffix.isEmpty ? 0 : 1)
                    
                    TextField("ACCOUNT SUFFIX", text: $accountSUffix)
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 2)
                    Text("\(accountSuffixCount)/3")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onChange(of: accountSUffix) {
                            accountSuffixCount = accountSUffix.count
                        }
                }
                
            }
            .font(.headline)
            .foregroundStyle(.gray)
            
            Spacer()
            
            HStack {
                Text("Continue".uppercased())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Image(systemName: "arrow.right")
                    .imageScale(.large)
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.green)
                    .frame(height: 55)
            )
            .padding(.bottom, 40)
            
            //            Spacer()
        }
        .padding(.horizontal)
    }
}

