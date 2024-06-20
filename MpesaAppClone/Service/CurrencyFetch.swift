//
//  CurrencyFetch.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 09/06/2024.
//

import Foundation
import Combine

class CurrencyFetch: ObservableObject {
    @Published var fetchedData: CurrencyModel?
    
    var cancellables = Set<AnyCancellable>()
    
    let apiKey = "" // <- add your api Key here from https://v6.exchangerate-api.com
    
    init() {
        Task {
            do {
                try await fetchCurrencyData()
            } catch {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCurrencyData() async throws {
         guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/KES") else { return }

         URLSession.shared.dataTaskPublisher(for: url)
             .tryMap { output -> Data in
                 guard let response = output.response as? HTTPURLResponse,
                       response.statusCode >= 200 && response.statusCode < 300 else {
                     throw URLError(.badServerResponse)
                 }
                 return output.data
             }
             .receive(on: DispatchQueue.main)
             .sink { completion in
                 switch completion {
                 case .finished:
                     print("Finished successfully")
                 case .failure(let error):
                     print("Completion error \(error.localizedDescription)")
                 }
             } receiveValue: { [weak self] data in
                 do {
                     let json = try JSONSerialization.jsonObject(with: data, options: [])
                     print("Raw JSON response: \(json)")
                     
                     let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
                     self?.fetchedData = currencyModel
                 } catch {
                     print("Decoding error: \(error.localizedDescription)")
                 }
             }
             .store(in: &cancellables)
     }
    
    // fetch the currency
//    func fetchCurrencyData() async throws {
//        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/KES") else { return }
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .receive(on: DispatchQueue.main)
//            .tryMap(downlaodData)
//            .decode(type: CurrencyModel.self, decoder: JSONDecoder())
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("Finished successfully")
//                case .failure(let error):
//                    print("Completion error \(error.localizedDescription)")
//                }
//            } receiveValue: {[weak self] data in
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print("Raw JSON response: \(json)")
//                    
//                    let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
//                    self?.fetchedData = currencyModel
//                } catch {
//                    print("Decoding error: \(error.localizedDescription)")
//                }
//            }
//            .store(in: &cancellables)
//        
//    }
    
    func downlaodData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
