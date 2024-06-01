//
//  SendMoney.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 29/05/2024.
//
import SwiftUI
struct TransactionButtonPressed: View {
    @Binding var detentHeight: CGFloat
    var transactionType: TransactionType
    var mainAction: MainAction
    @State var path: SendOrRequest = .send
    
    @State private var send: Bool = false
    @State private var request: Bool = false
    @State private var global: Bool = false
    
    
    var body: some View {
        VStack {
            if transactionType == .sendMoney {
                TransactionSheet(
                    transactionTitle: "send and request",
                    isImageSystem: true,
                    imageName1: "arrow.up.right",
                    transaction1: "send money",
                    background: .green,
                    imageName2: "arrow.down.backward",
                    transaction2: "request money",
                    imageName3: "globe",
                    transaction3: "GLOBAL",
                    imageName4: "qrcode",
                    transaction4: "Scan qr",
                    imageName5: "",
                    transaction5: "",
                    buttonPressed1: { handleButtonPressed(action: .send(.sendMoney)) },
                    buttonPressed2: { handleButtonPressed(action: .send(.requestMoney)) },
                    buttonPressed3: { handleButtonPressed(action: .send(.global)) },
                    buttonPressed4: { handleButtonPressed(action: .send(.scanQr)) },
                    buttonPressed5: {}
                )
                .presentationDetents([.fraction(detentHeight)])
                
            } else if transactionType == .pay {
                TransactionSheet(
                    transactionTitle: "pay",
                    isImageSystem: true,
                    imageName1: "chart.bar.doc.horizontal",
                    transaction1: "pay bill",
                    background: .blue,
                    imageName2: "basket",
                    transaction2: "buy goods",
                    imageName3: "iphone.gen3",
                    transaction3: "pochi la biashara",
                    imageName4: "creditcard",
                    transaction4: "global pay",
                    imageName5: "qrcode.viewfinder",
                    transaction5: "scan qr",
                    buttonPressed1: { handleButtonPressed(action: .pay(.payBill)) },
                    buttonPressed2: { handleButtonPressed(action: .pay(.buyGoods)) },
                    buttonPressed3: { handleButtonPressed(action: .pay(.pochi)) },
                    buttonPressed4: { handleButtonPressed(action: .pay(.globalPay)) },
                    buttonPressed5: { handleButtonPressed(action: .pay(.globalPay)) }
                )
                .presentationDetents([.fraction(detentHeight)])
                
            } else if transactionType == .withdraw {
                TransactionSheet(
                    transactionTitle: "withdraw",
                    isImageSystem: true,
                    imageName1: "house",
                    transaction1: "withdraw",
                    background: .pink,
                    imageName2: "banknote",
                    transaction2: "withdraw at atm",
                    imageName3: "qrcode",
                    transaction3: "scan qr",
                    imageName4: "",
                    transaction4: "",
                    imageName5: "",
                    transaction5: "",
                    buttonPressed1: { handleButtonPressed(action: .withdraw(.withdraw)) },
                    buttonPressed2: { handleButtonPressed(action: .withdraw(.withdrawAtATM)) },
                    buttonPressed3: { handleButtonPressed(action: .withdraw(.withdrawAtATM)) },
                    buttonPressed4: { handleButtonPressed(action: .withdraw(.withdrawAtATM)) },
                    buttonPressed5: {}
                )
                .presentationDetents([.fraction(detentHeight)])
                
            } else {
                TransactionSheet(
                    transactionTitle: "airtime",
                    isImageSystem: true,
                    imageName1: "phone.arrow.down.left.fill",
                    transaction1: "buy for my number",
                    background: .blue.opacity(0.6),
                    imageName2: "phone.arrow.up.right.fill",
                    transaction2: "buy for other number",
                    imageName3: "iphone.gen2.radiowaves.left.and.right",
                    transaction3: "buy bundles",
                    imageName4: "",
                    transaction4: "",
                    imageName5: "",
                    transaction5: "",
                    buttonPressed1: { handleButtonPressed(action: .airtime(.buyForMyNumber)) },
                    buttonPressed2: { handleButtonPressed(action: .airtime(.buyForOtherNumber)) },
                    buttonPressed3: { handleButtonPressed(action: .airtime(.buyBundles)) },
                    buttonPressed4: { },
                    buttonPressed5: {}
                )
                .presentationDetents([.fraction(detentHeight)])
            }
        }
        .sheet(isPresented: $send) {
            SendRequest(path: $path)
        }
        .sheet(isPresented: $request) {
            SendRequest(path: $path)
        }
        .sheet(isPresented: $global) {
            Global()
        }
    }
    
    func handleButtonPressed(action: MainAction) {
        switch action {
        case .send(let sendAction):
            switch sendAction {
            case .sendMoney:
                send.toggle()
                self.path = .send
                
            case .requestMoney:
                request.toggle()
                self.path = .request
                
            case .global:
                global.toggle()
            case .scanQr:
                print("Scan QR button pressed")
            }
            
        case .pay(let payAction):
            switch payAction {
            case .payBill:
                print("Pay Bill button pressed")
            case .buyGoods:
                print("Buy Goods button pressed")
            case .pochi:
                print("Pochi button pressed")
            case .globalPay:
                print("Global Pay button pressed")
            }
            
        case .withdraw(let withdrawAction):
            switch withdrawAction {
            case .withdraw:
                print("Withdraw button pressed")
            case .withdrawAtATM:
                print("Withdraw at ATM button pressed")
            case .scanQr:
                print("scan qr code")
            }
            
        case .airtime(let airtimeAction):
            switch airtimeAction {
            case .buyForMyNumber:
                print("Buy for My Number button pressed")
            case .buyForOtherNumber:
                print("Buy for Other Number button pressed")
            case .buyBundles:
                print("Buy Bundles button pressed")
            }
        }
    }
    
}

#Preview {
    TransactionButtonPressed(detentHeight: .constant(0.5), transactionType: .airtime, mainAction: .airtime(.buyBundles)
    )
}



