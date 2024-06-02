//
//  CountriesFetch.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 01/06/2024.
//
// countries API KEY - qsjpF6Qg1NrZ75UJlRdUH0r8sFEtoPJfJ48ViyvI


import Foundation
import Combine

final class CountriesFetch: ObservableObject {
    static let shared = CountriesFetch()
    
    @Published var fetchedSend: [Country] = []
    @Published var allCountries: [Country] = []
    
    var cancellables = Set<AnyCancellable>()
    
    var sendCountries = ["tanzania", "rwanda", "uganda", "zambia", "malawi", "botswana", "burundi", "pakistan", "bangladesh"]
    
    let countryNames = ["nigeria", "kenya", "egypt", "algeria", "morocco", "germany", "france", "italy", "sweden", "austria", "indonesia", "canada", "argentina", "colombia", "chile", "peru", "venezuela", "ecuador", "bolivia", "paraguay", "uruguay"]
    
    /*
     // Europe
     "germany", , "united kingdom", , "spain",
     "poland", "netherlands", "belgium", ,
     // Asia
     "china", "india", "japan", "south korea", ,
     "saudi arabia", "thailand", "malaysia", "philippines", "vietnam",
     // North America
     "united states", ,
     // South America
     "brazil", ,
    
     */
    
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
        for country in countryNames {
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
                    self?.allCountries.append(contentsOf: countries)
                }
                .store(in: &cancellables)
        }
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
    
    let allCountries = ["afghanistan", "albania", "algeria", "palestine", "andora", "angola", "argentina", "armenia", "arzebahjan", "australia", "austria", "bahrain", "bolivia", "brazil", "canada", "chile", "china", "colombia", "comoros", "djbouti", "dominica", "england", "estonia", "finland", "france", "germany", "greece", "hongkong", "hungary", "india", "italy", "jamaica", "kuwait", "latvia", "malawi", "malaysia", "namibia", "nauru", "nigeria", "paraguay", "peru", "southAfrica", "usa"]
    
//    let countryCurrencyArray = {
//      "afghanistan": "AFN",
//      "albania": "ALL",
//      "algeria": "DZD",
//      "palestine": "ILS",
//      "andorra": "EUR",
//      "angola": "AOA",
//      "argentina": "ARS",
//      "armenia": "AMD",
//      "azerbaijan": "AZN",
//      "australia": "AUD",
//      "austria": "EUR",
//      "bahrain": "BHD",
//      "bolivia": "BOB",
//      "brazil": "BRL",
//      "canada": "CAD",
//      "chile": "CLP",
//      "china": "CNY",
//      "colombia": "COP",
//      "comoros": "KMF",
//      "djibouti": "DJF",
//      "dominica": "XCD",
//      "england": "GBP",
//      "estonia": "EUR",
//      "finland": "EUR",
//      "france": "EUR",
//      "germany": "EUR",
//      "greece": "EUR",
//      "hongkong": "HKD",
//      "hungary": "HUF",
//      "india": "INR",
//      "italy": "EUR",
//      "jamaica": "JMD",
//      "kuwait": "KWD",
//      "latvia": "EUR",
//      "malawi": "MWK",
//      "malaysia": "MYR",
//      "namibia": "NAD",
//      "nauru": "AUD",
//      "nigeria": "NGN",
//      "paraguay": "PYG",
//      "peru": "PEN",
//      "southAfrica": "ZAR",
//      "usa": "USD"
//    };

}
