//
//  SendMoney.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 29/05/2024.
//
import SwiftUI
struct TransactionButtonPressed: View {
    @EnvironmentObject var navigationState: NavigationState
    @Binding var detentHeight: CGFloat
    @Binding var transactionType: TransactionType
    var mainAction: MainAction
    @State var path: SendOrRequest = .send
    
    @State private var send: Bool = false
    @State private var request: Bool = false
    @State private var global: Bool = false
    @State private var paybill: Bool = false
    @State private var buygoods: Bool = false
    @State private var withdraw: Bool = false
    @State private var atm: Bool = false
    @State private var buyAirtime: Bool = false
    
    
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
                .environmentObject(navigationState)
                .presentationDetents([.fraction(detentHeight)])
                .sheet(isPresented: $send) {
                    SendRequest(path: $path)
                }
                .sheet(isPresented: $request) {
                    SendRequest(path: $path)
                }
                .sheet(isPresented: $global) {
                    Global()
                }
                
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
                .environmentObject(navigationState)
                .presentationDetents([.fraction(detentHeight)])
                .sheet(isPresented: $paybill, content: {
                    PayBill()
                })
                .sheet(isPresented: $buygoods, content: {
                    BuyGoods()
                })
                
            } else if transactionType == .withdraw {
                TransactionSheet(
                    transactionTitle: "withdraw",
                    isImageSystem: true,
                    imageName1: "storefront.fill",
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
                .environmentObject(navigationState)
                .presentationDetents([.fraction(detentHeight)])
                .sheet(isPresented: $withdraw) {
                    WithdrawView()
                }
                .sheet(isPresented: $atm, content: {
                    WithdrawView(agentView: false)
                })
                
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
                .environmentObject(navigationState)
                .presentationDetents([.fraction(detentHeight)])
                .sheet(isPresented: $buyAirtime, content: {
                    BuyAirtmieView()
                })
            }
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
                paybill.toggle()
            case .buyGoods:
                buygoods.toggle()
            case .pochi:
                print("Pochi button pressed")
            case .globalPay:
                print("Global Pay button pressed")
            }
            
        case .withdraw(let withdrawAction):
            switch withdrawAction {
            case .withdraw:
                withdraw.toggle()
            case .withdrawAtATM:
                atm.toggle()
            case .scanQr:
                print("scan qr code")
            }
            
        case .airtime(let airtimeAction):
            switch airtimeAction {
            case .buyForMyNumber:
                buyAirtime.toggle()
            case .buyForOtherNumber:
                print("Buy for Other Number button pressed")
            case .buyBundles:
                print("Buy Bundles button pressed")
            }
        }
    }
    
}

#Preview {
    TransactionButtonPressed(detentHeight: .constant(0.5), transactionType: .constant(.airtime), mainAction: .airtime(.buyBundles)
    )
}



