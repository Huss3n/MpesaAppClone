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
    var cancellables = Set<AnyCancellable>()

    var allCountries: [Country] = []
    
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
                } receiveValue: {  receivedCountries in
                    self.allCountries = receivedCountries
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
