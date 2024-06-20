//
//  Stats.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 13/06/2024.
//

import SwiftUI
import Charts

final class StatsVM: ObservableObject {
    @Published var amounts: [Double] = []

    init() {
        Task(priority: .userInitiated) {
            await fetchTransactionHistory()
        }
    }

    func fetchTransactionHistory() async {
        do {
            let transactions = try await DatabaseService.instance.fetchTransactionHistory()
            let amounts = transactions.map { $0.amount }
            await MainActor.run {
                self.amounts = amounts
            }
        } catch {
            print("Error fetching transactions: \(error.localizedDescription)")
        }
    }
}


struct Stats: View {
    @StateObject private var vm = StatsVM()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.amounts.isEmpty {
                    Text("Loading...")
                } else {
                    LineChart(data: vm.amounts)
                        .frame(height: 300)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}

struct LineChart: View {
    let data: [Double]

    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.offset) { index, amount in
                LineMark(
                    x: .value("Day", index + 1),
                    y: .value("Amount", amount)
                )
                .foregroundStyle(.green)
            }
        }
        .chartYScale(domain: 0...10000)
        .chartXAxis {
            AxisMarks(values: .stride(by: 1))
        }
        .chartYAxis {
            AxisMarks(values: .automatic(desiredCount: 10))
            AxisMarks(position: .leading)
        }
    }
}


#Preview {
    Stats()
}
