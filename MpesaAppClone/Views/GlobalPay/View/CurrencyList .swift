//
//  CurrencyList.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 07/06/2024.
//

import SwiftUI

struct CurrencyList: View {
    @StateObject var currency = CurrencyFetch()
    @State private var searchText: String = ""
    @Binding var chosenCurrency: String
    @Binding var chosenCurrencyValue: Double
    @Binding var dismiss: Bool
//    var returnToGlobal: () -> ()
    
    var body: some View {
        NavigationStack {
            if let data = currency.fetchedData {
                List(filteredCurrencies(data.conversionRates, searchTerm: searchText).sorted(by: >), id: \.key) { currencyName, rate in
                    HStack {
                        Text(currencyName)
                            .onTapGesture {
                                chosenCurrency = currencyName
                                chosenCurrencyValue = rate
                                dismiss.toggle()
                            }
                        Spacer()
                        Text("\(1 / rate, specifier: "%.4f")")
                    }
                }
                .searchable(text: $searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "arrow.left")
                            .onTapGesture {
                                dismiss.toggle()
                            }
                    }
                }
            } else {
                ProgressView()
            }
        }
    }
    
    // Filter currencies based on the search term
    func filteredCurrencies(_ conversionRates: [String: Double], searchTerm: String) -> [String: Double] {
        if searchTerm.isEmpty {
            return conversionRates
        } else {
            return conversionRates.filter { $0.key.lowercased().contains(searchTerm.lowercased()) }
        }
    }
}

#Preview {
    CurrencyList(chosenCurrency: .constant("USD"), chosenCurrencyValue: .constant(130.4), dismiss: .constant(true))
}
