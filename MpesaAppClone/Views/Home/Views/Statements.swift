//
//  Statements.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 29/05/2024.
//

import SwiftUI
import SwiftUI

@MainActor
class StatementsVM: ObservableObject {
    static let instance = StatementsVM()
    
    @Published var transactions: [Transaction] = []
    
    init() {
        Task {
            await fetchTransactions()
        }
    }
    
    func fetchTransactions() async {
        do {
            let fetchedTransactions = try await DatabaseService.instance.fetchTransactionHistory()
            self.transactions = fetchedTransactions.sorted { $0.date > $1.date }
        } catch {
            print("Error fetching transactions: \(error.localizedDescription)")
        }
    }
}

struct Statements: View {
    @StateObject private var vm = StatementsVM.instance
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var searchTransaction: String = ""
    @State private var showSearchText: Bool = false
    @FocusState var keyboard: Bool
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        ForEach(vm.transactions, id: \.date) { transaction in
                            var formattedDate: String {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "d MMM, h:mm a"
                                return formatter.string(from: transaction.date)
                            }
                            
                            HStack {
                                Circle()
                                    .fill(.green.opacity(0.4))
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        Text("\(transaction.contact?.familyName.prefix(1) ?? "")\(transaction.contact?.givenName.prefix(1) ?? "")")
                                            .font(.headline)
                                            .fontWeight(.light)
                                    }
                                
                                VStack(alignment: .leading) {
                                    Text("\(transaction.contact?.givenName ?? "") \(transaction.contact?.familyName ?? "")")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        
                                    Text(transaction.contact?.mobileNumber ?? transaction.phoneNumber ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                }
                                
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("-KSH. \(transaction.amount.formatted(.number.precision(.fractionLength(2)).grouping(.automatic)))")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                    
                                    Text(formattedDate)
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(systemName: "arrow.left")
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            VStack {
                                if showSearchText {
                                    Image(systemName: "xmark.circle")
                                } else {
                                    Image(systemName: "magnifyingglass")
                                }
                            }
                            .frame(width: 50, height: 30)
                            //                            .background(.red)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    showSearchText.toggle()
                                }
                                keyboard = true
                            }
                        }
                    }
                    .padding(.top, 12)
                    
                }
                
                VStack {
                    if showSearchText {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray.opacity(0.3))
                            .frame(width: 250, height: 35)
                            .overlay {
                                TextField("Search", text: $searchTransaction)
                                    .padding(.leading)
                                    .focused($keyboard)
                            }
                            .offset(y: -8)
                        
                    } else {
                        Text("M-PESA STATEMENTS")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .offset(y: -30)
                
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(colorScheme == .light ? Color.black.opacity(0.8) : Color.gray.opacity(0.3) )
                    .frame(width: 230, height: 40)
                    .overlay {
                        HStack {
                            Image(systemName: "doc")
                                .imageScale(.medium)
                            
                            Text("EXPORT STATEMENTS")
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.green)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()
                    .opacity(showSearchText ? 0 : 1)
            }
            .onAppear {
                Task {
                    await vm.fetchTransactions()
                }
            }
            .refreshable {
                Task {
                    await vm.fetchTransactions()
                }
            }
        }
    }
}

#Preview {
    Statements()
}
