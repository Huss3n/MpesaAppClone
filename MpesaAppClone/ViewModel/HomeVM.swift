//
//  HomeVM.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 11/06/2024.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage


class HomeVM: ObservableObject {
    static let shared = HomeVM()
    @Published var mpesaBalance: Double = 0
    @Published var username: String = ""
    @Published var transactions: [Transaction] = []
    @Published var requestState: Bool = false

    private var timer: Timer?
    
    init() {
        Task {
            await fetchUserDetails()
            await fetchTransactionHistory()
            await fetchRequestState()
        }
        
        startRequestStateTimer() 
    }
    
    deinit {
          stopRequestStateTimer()
      }
    
    
    func fetchUserDetails() async {
        do {
            let user = try await DatabaseService.instance.fetchUserDetails()
            
            await MainActor.run {
                self.mpesaBalance = user.mpesaBalance
                self.username = user.firstName
            }
        } catch {
            print("Error fetching users")
        }
    }
    
    func fetchTransactionHistory() async {
        do {
            let transactions = try await DatabaseService.instance.fetchTransactionHistory()
            await MainActor.run {
                self.transactions = transactions.sorted { $0.date > $1.date }
            }
        } catch {
            print("Error fetching transaction history: \(error)")
        }
    }
    
    func fetchRequestState() async {
        do {
            guard let reqStatus = try await DatabaseService.instance.fetchRequestState() else { return }
            await MainActor.run {
                self.requestState = reqStatus
                print("fetched req status \(reqStatus)")
            }
            
        } catch {
            print("Error in continous fetch \(error.localizedDescription)")
        }
    }
    
    
    private func startRequestStateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.fetchRequestState()
            }
        }
    }
    
    private func stopRequestStateTimer() {
        timer?.invalidate()
        timer = nil
    }

    
    private func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Image download failed", code: 0, userInfo: nil)
        }
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "Invalid image data", code: 0, userInfo: nil)
        }
        return image
    }
}
