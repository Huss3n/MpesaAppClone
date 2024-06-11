//
//  TransactView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 03/06/2024.
//

import SwiftUI

struct TransactView: View {
    @State var send: SendOrRequest = .send
    @State var req: SendOrRequest = .request
    
    @State private var sendPressed: Bool = false
    @State private var reqPressed: Bool = false
    @State private var airtimePressed: Bool = false
    @State private var withdrawAgentPressed: Bool = false
    @State private var withdrawAtmPressed: Bool = false
    @State private var globalPressed: Bool = false
    @State private var payBillPressed: Bool = false
    @State private var buyGoodsPressed: Bool = false
    @State private var globalPayPressed: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("FREQUENTS")
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            frequents(
                                circleText: "JD",
                                title: "JOHN DOE",
                                type: "Send Money",
                                textColor: .purple
                            )
                            frequents(
                                circleText: "KP",
                                title: "KPLC PREPAID",
                                type: "Pay Bill",
                                textColor: .blue
                            )
                            frequents(
                                circleText: "NS",
                                title: "Naivas Supermarket",
                                type: "Buy Goods",
                                textColor: .orange
                            )
                            frequents(
                                circleText: "NH",
                                title: "NHIF",
                                type: "Pay Bill",
                                textColor: .green
                            )
                            
                            frequents(
                                circleText: "SF",
                                title: "Safaricom Postpaid",
                                type: "Pay Bill",
                                textColor: .orange
                            )
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Text("FINANCIAL SERVICES")
                    HStack(spacing: 50) {
                        VStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Text("U")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                }
                            
                            Text("FULIZA")
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Circle()
                                .fill(.cyan)
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Text("KCB")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                }
                            
                            Text("KCB M-PESA")
                                .font(.subheadline)
                        }
                        
                        NavigationLink {
                            MshwariView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            VStack {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 50, height: 50)
                                    .overlay {
                                        Text("M")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                    }
                                
                                Text("M-SHWARI")
                                    .font(.subheadline)
                            }
                            .padding(.horizontal)
                        }
                        .tint(.primary)
                        
                    }

                    
                    Text("WALLETS")
                    VStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "briefcase.fill")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                        
                        Text("POCHI LA")
                            .font(.subheadline)
                        Text("BIASHARA")
                            .font(.subheadline)
                    }
                    
                    Text("SEND AND REQUEST")
                    HStack {
                        transactionIcons(
                            imageName: "arrow.up.right",
                            background: .green,
                            name: "SEND MONEY"
                        )
                        .onTapGesture {
                            sendPressed.toggle()
                        }
                        
                        transactionIcons(
                            imageName: "arrow.down.backward",
                            background: .green,
                            name: "RECEIVE MONEY"
                        )
                        .onTapGesture {
                            reqPressed.toggle()
                        }
                        
                        transactionIcons(
                            imageName: "person.3.fill",
                            background: .green,
                            name: "SEND TO MANY"
                        )
                    }
                    .padding(.leading, -6)
                    
                    
                    transactionIcons(
                        imageName: "globe",
                        background: .green,
                        name: "GLOBAL"
                    )
                    .onTapGesture(perform: {
                        globalPressed.toggle()
                    })
                    .padding(
                        .leading,
                        10
                    )
                    
                    
                    
                    Text("PAY")
                    HStack(spacing: 28) {
                        
                        transactionIcons(
                            imageName: "chart.bar.doc.horizontal",
                            background: .blue,
                            name: "PAY BILL"
                        ).onTapGesture {
                            payBillPressed.toggle()
                        }
                        
                        
                        transactionIcons(
                            imageName: "basket",
                            background: .blue,
                            name: "BUY GOODS"
                        ) .onTapGesture {
                            buyGoodsPressed.toggle()
                        }
                       
                        
                        transactionIcons(
                            imageName: "iphone.gen3",
                            background: .blue,
                            name: "POCHI LA BIASHARA"
                        )
                    }
                    .padding(.leading, 4)
                    
                    transactionIcons(
                        imageName: "creditcard",
                        background: .blue,
                        name: "GLOBAL PAY"
                    )
                        .padding(.leading, -8)
                        .onTapGesture {
                            globalPayPressed.toggle()
                        }
                    
                    
                    Text("WITHDRAW")
                    VStack(alignment: .leading, spacing: 50) {
                        HStack {
                            
                            
                            transactionIcons(
                                imageName: "storefront.fill",
                                background: .pink,
                                name: "WITHDRAW AT AGENT"
                            )
                            .onTapGesture {
                                withdrawAtmPressed.toggle()
                            }
                            
                            
                            transactionIcons(
                                imageName: "banknote",
                                background: .pink,
                                name: "WITHDRAW AT ATM"
                            )
                            .onTapGesture {
                                withdrawAtmPressed.toggle()
                            }
                            
                            transactionIcons(
                                imageName: "banknote",
                                background: .pink,
                                name: "WITHDRAW AT ATM"
                            )
                                .padding(.leading, 18)
                                .opacity(0)
                        }
                    }
                    
                    Text("AIRTIME")
                    HStack {
                        transactionIcons(
                            imageName: "phone.arrow.down.left.fill",
                            background: .blue.opacity(0.5),
                            name: "AIRTIME FOR MY NUMBER"
                        ).onTapGesture {
                            airtimePressed.toggle()
                        }
                        
                        transactionIcons(
                            imageName: "banknote",
                            background: .blue.opacity(
                                0.5
                            ),
                            name: "AIRTIME FOR OTHER NUMBER"
                        )
                        
                        transactionIcons(
                            imageName: "banknote",
                            background: .pink,
                            name: "WITHDRAW AT ATM"
                        )
                            .padding(.leading, 18)
                            .opacity(0)
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 30)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .navigationTitle("Transact")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .sheet(isPresented: $sendPressed) {
                    SendRequest(path: $send)
                }
                .sheet(isPresented: $reqPressed) {
                    SendRequest(path: $req)
                }
                .sheet(isPresented: $withdrawAgentPressed) {
                    WithdrawView()
                }
                .sheet(isPresented: $withdrawAtmPressed) {
                    WithdrawView(agentView: false)
                }
                .sheet(isPresented: $airtimePressed) {
                    BuyAirtmieView()
                }
                .sheet(isPresented: $globalPressed) {
                    Global()
                }
                .sheet(isPresented: $payBillPressed) {
                    PayBill()
                }
                .sheet(isPresented: $buyGoodsPressed) {
                    BuyGoods()
                }
                .navigationDestination(isPresented: $globalPayPressed) {
                    GlobalPayView()
                        .navigationBarBackButtonHidden()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    TransactView()
}

extension TransactView {
    private func frequents(circleText: String, title: String, type: String, textColor: Color) -> some View {
        VStack(alignment: .center, spacing: 12) {
            Circle()
                .fill(.gray.opacity(0.3))
                .frame(width: 40, height: 40)
                .overlay {
                    Text(circleText)
                        .foregroundStyle(textColor)
                }
            Text(title.uppercased())
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            
            Text(type)
                .foregroundStyle(.gray)
                .font(.subheadline)
        }
        .frame(width: 90)
    }
    private func transactionIcons(imageName: String, background: Color, name: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.medium)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding()
                .background(background)
                .clipShape(Circle())
            Text(name)
                .font(.subheadline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
}
