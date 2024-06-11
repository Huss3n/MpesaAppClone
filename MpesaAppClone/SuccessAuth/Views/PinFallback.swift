//
//  PinFallback.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 09/06/2024.
//

import SwiftUI

struct PinFallback: View {
    @EnvironmentObject var navigationState: NavigationState
    @ObservedObject var transactions = MpesaBalance.instance
    @State private var pin = ""
    @State private var isVerifying = false
    @State private var isPinCorrect = false
    @Binding var cancel: Bool
    // successful auth -> complete transaction
    @State private var authSuccess: Bool = false
    @State private var completeTransaction: Bool = false
    
    let correctPin = "1234"  // Example correct PIN
    var name: String = "Hussein Aisak"
    var phoneNumber: String = "0700000000"
    var amount: Double = 0
    var transactionCost: Double = 0
    var contact: Contact?
    var transactionType: TransactionType
    
    // withdraw details
    var agentNumber: String
    var storeNumber: String
    
    // buy airtime
    
    // send
    
    var body: some View {
        VStack {
            Image(systemName: "xmark")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    cancel.toggle()
                }
            
            // MARK: SEND AND AIRTIME
            if transactionType == .sendMoney || transactionType == .airtime {
                // add the image from the contact and name here
                if contact == nil {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(width:80, height: 80)
                        .overlay {
                            Image(systemName: "person")
                                .font(.largeTitle)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: -10)
                    
                    Text("HUSSEIN AISAK")
                        .font(.headline)
                    HStack {
                        Text("PHONE NUMBER")
                            .font(.headline)
                        Text("25712345678")
                            .fontWeight(.light)
                    }
                    
                } else {
                    // show contact info
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .overlay {
                            Text(contact?.initials ?? "")
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: -30)
                }
            }
            
            // MARK: WITHDRAW
            if transactionType == .withdraw {
                Circle()
                    .fill(.gray.opacity(0.3))
                    .frame(width:80, height: 80)
                    .overlay {
                        Image(systemName: "building.columns")
                            .font(.title)
                    }
            }
            
            // MARK: WITHDRAW
            if transactionType == .withdraw {
                Text("HELLO WORLD")
                    .fontWeight(.semibold)
                HStack {
                    Text("AGENT NUMBER")
                    Text(agentNumber)
                        .fontWeight(.light)
                }
                HStack {
                    Text("STORE NUMBER")
                    Text(storeNumber)
                        .fontWeight(.light)
                }
            }
            
            // MARK: SEND
            if transactionType == .sendMoney {
                Text(name.uppercased())
                    .fontWeight(.semibold)
                HStack {
                    Text("PHONE NUMBER")
                    Text(phoneNumber)
                        .fontWeight(.light)
                }
            }
            
            HStack {
                Text("KSH")
                    .font(.headline)
                
                Text("\(String(format: "%.2f", amount))")
                    .fontWeight(.light)
                
                Text("FEE: KSH. \(String(format: "%.2f", transactionCost))")
                    .fontWeight(.light)
            }
            
            Spacer()
            Spacer()
            
            Text("ENTER M-PESA PIN")
            
            HStack(spacing: 20) {
                ForEach(0..<4) { index in
                    Circle()
                        .stroke(lineWidth: 1)
                        .background(Circle().fill(self.fillColor(for: index)))
                        .frame(width: 40, height: 40)
                        .opacity(isVerifying ? 0.5 : 1)
                        .animation(
                            isVerifying ? Animation.default.repeatForever(
                                autoreverses: true
                            ) : .default
                        )
                }
            }
            
            Spacer()
            
            KeypadView(pin: $pin, onSubmit: verifyPin)
                .disabled(isVerifying)
        }
        .padding()
        .onAppear {
            Task {
                print("amount: \(amount)")
                print("transaction cost: \(transactionCost)")
                print("Deducting amount: \(amount + transactionCost)")
                let result = await LocalAuth.shared.authenticateWithBiometrics(reason: "Biometrics needed to complete tranasction")
                if result {
                    await transactions.deductAmount(amount: amount, transaction: transactionCost)
                    let transaction = Transaction(contact: contact, phoneNumber: phoneNumber, date: Date(), amount: amount)
                    Task {
                        do {
//                            try await FirebaseAuth.instance.saveTransactionHistory(transaction: transaction)
                        } catch {
                            print("Error saving transaction: \(error.localizedDescription)")
                        }
                    }
                    print("New balance: \(transactions.mpesaBalance)")
                    completeTransaction.toggle()
                }
            }
        }
        .sheet(isPresented: $completeTransaction,
               content: {
            AuthSuccess(
                name: contact?.givenName ?? "",
                phoneNumber: contact?.mobileNumber ?? phoneNumber,
                transactionCost: transactionCost,
                contact: contact,
                transactionType: transactionType,
                cancel: $cancel,
                authSuccess: $completeTransaction,
                amount: amount
            )
            .environmentObject(navigationState)
        })
    }
    
    private func fillColor(for index: Int) -> Color {
        if index < pin.count {
            return isPinCorrect ? .green : .green
        }
        return Color.clear
    }
    
    private func verifyPin() {
        guard pin.count == 4 else { return }
        
        isVerifying = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isPinCorrect = self.pin == self.correctPin
            self.isVerifying = false
            
            if self.isPinCorrect {
                // Handle successful PIN entry
                withAnimation(.easeIn) {
                    // deduct amount sent from balance
                    Task {
                        await transactions.deductAmount(amount: amount, transaction: transactionCost)
                    }
                    let transaction = Transaction(contact: contact, phoneNumber: phoneNumber, date: Date(), amount: amount)
                    Task {
                        do {
//                            try await FirebaseAuth.instance.saveTransactionHistory(transaction: transaction)
                        } catch {
                            print("Error saving transaction: \(error.localizedDescription)")
                        }
                    }
                    completeTransaction.toggle()
                }
            } else {
                // Handle incorrect PIN entry
                self.pin = ""
            }
        }
    }
}

#Preview {
    PinFallback(cancel: .constant(true), transactionType: .airtime, agentNumber: "1234", storeNumber: "1234")
}
struct KeypadView: View {
    @Binding var pin: String
    let onSubmit: () -> Void
    
    let buttons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "⌫"]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 70) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.handleTap(button: button)
                        }) {
                            Text(button)
                                .font(.system(size: 28))
                                .frame(width: 60, height: 60)
                                .cornerRadius(30)
                        }
                    }
                }
            }
        }
    }
    
    private func handleTap(button: String) {
        switch button {
        case "⌫":
            if !pin.isEmpty {
                pin.removeLast()
            }
        case "":
            break
        default:
            if pin.count < 4 {
                pin.append(button)
                if pin.count == 4 {
                    onSubmit()
                }
            }
        }
    }
}
