//
//  CountriesFetch.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 01/06/2024.
//
// countries API KEY


import Foundation
import Combine

final class CountriesFetch: ObservableObject {
    static let shared = CountriesFetch()
    
    @Published var fetchedSend: [Country] = []
    @Published var allCountries: [Country] = []
    
    var cancellables = Set<AnyCancellable>()
    
    var sendCountries = ["tanzania", "rwanda", "uganda", "zambia", "malawi", "botswana", "burundi", "pakistan", "bangladesh"]
    
    func fetchSendCountries() async throws {
        for country in sendCountries {
            // extract each country and fetch its details
            guard let url = URL(string: "https://restcountries.com/v3.1/name/\(country)") else { return }
//            let (data, result) = URLSession.shared.data(from: url)
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(downlaodData)
                .decode(type: [Country].self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Finished \(completion)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { [weak self] countries in
                    self?.fetchedSend.append(contentsOf: countries)
                }
                .store(in: &cancellables)
        }
    }

    func fetchAllCountries() async throws {
            guard let url = URL(string: "https://restcountries.com/v3.1/name/all") else { return }
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(downlaodData)
                .decode(type: [Country].self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Finished \(completion)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: {  _ in
                    // append here
                }
                .store(in: &cancellables)
    }

    func downlaodData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw URLError(.badServerResponse)
              }
        return output.data
    }
    
}


final class AllCountries {
    static let shared = AllCountries()
    let countryCurrencyArray = [
      "afghanistan": "AFN",
      "albania": "ALL",
      "algeria": "DZD",
      "palestine": "ILS",
      "andorra": "EUR",
      "angola": "AOA",
      "argentina": "ARS",
      "armenia": "AMD",
      "azerbaijan": "AZN",
      "australia": "AUD",
      "austria": "EUR",
      "bahrain": "BHD",
      "bolivia": "BOB",
      "brazil": "BRL",
      "canada": "CAD",
      "chile": "CLP",
      "china": "CNY",
      "colombia": "COP",
      "comoros": "KMF",
      "djibouti": "DJF",
      "dominica": "XCD",
      "england": "GBP",
      "estonia": "EUR",
      "finland": "EUR",
      "france": "EUR",
      "germany": "EUR",
      "greece": "EUR",
      "hongkong": "HKD",
      "hungary": "HUF",
      "india": "INR",
      "italy": "EUR",
      "jamaica": "JMD",
      "kuwait": "KWD",
      "latvia": "EUR",
      "malawi": "MWK",
      "malaysia": "MYR",
      "namibia": "NAD",
      "nauru": "AUD",
      "nigeria": "NGN",
      "paraguay": "PYG",
      "peru": "PEN",
      "southAfrica": "ZAR",
      "usa": "USD"
    ]
}
