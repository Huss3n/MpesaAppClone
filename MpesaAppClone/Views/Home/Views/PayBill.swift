//
//  PayBill.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 02/06/2024.
//

import SwiftUI

struct PayBill: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var search: String = ""
    @State private var enterPaybill: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray)
                            .frame(width: 60, height: 6)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.green)
                            .frame(width: 14, height: 6, alignment: .leading)
                            .offset(x: -23)
                    }
                }
                .padding(.top, 20)
                
                Text("PAY BILL")
                    .font(.title)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                    
                    
                    TextField("Search Contacts", text: $search)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.gray.opacity(0.2))
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        ScrollView(.horizontal) {
                            HStack {
                                NavigationLink {
                                    TVandInternet()
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    Text("TV AND INTERNET")
                                        .padding(8)
                                        .font(.headline)
                                        .background(
                                            RoundedRectangle(cornerRadius: 25.0)
                                                .fill(.gray.opacity(0.2))
                                        )
                                }
                                .tint(.primary)

                                
                                Text("WATER")
                                    .padding(8)
                                    .font(.headline)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(.gray.opacity(0.2))
                                    )
                                
                                NavigationLink {
                                    SafSlide()
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    Text("SAFARICOM")
                                        .padding(8)
                                        .font(.headline)
                                        .background(
                                            RoundedRectangle(cornerRadius: 25.0)
                                                .fill(.gray.opacity(0.2))
                                        )
                                }
                                .tint(.primary)

                                NavigationLink {
                                    Electricity()
                                        .navigationBarBackButtonHidden()
                                    
                                } label: {
                                    Text("ELECTRICITY")
                                        .padding(8)
                                        .font(.headline)
                                        .background(
                                            RoundedRectangle(cornerRadius: 25.0)
                                                .fill(.gray.opacity(0.2))
                                        )
                                }
                                .tint(.primary)
                                

                                Text("GOVERNMENT SERVICES")
                                    .padding(8)
                                    .font(.headline)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(.gray.opacity(0.2))
                                    )
                                
                                Text("BANKS")
                                    .padding(8)
                                    .font(.headline)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(.gray.opacity(0.2))
                                    )
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        HStack {
                            VStack {
                                Circle()
                                    .fill(colorScheme == .light ? Color.blue.opacity(0.1) : .white)
                                    .frame(width: 50, height: 50)
                                    .overlay {
                                        Image("absa")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 50, height: 50)
                                    }
                                
                                Text("Absa Bank Kenya PL")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(4)
                            }
                            .frame(width: 90)
                            
                            VStack {
                                Circle()
                                    .fill(colorScheme == .light ? Color.blue.opacity(0.1) : .white)
                                    .frame(width: 50, height: 50)
                                    .overlay {
                                        Text("KP")
                                            .foregroundStyle(.blue.opacity(0.8))
                                    }
                                
                                Text("KPLC Prepaid")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(4)
                            }
                            .frame(width: 90)
                            
                            VStack {
                                Circle()
                                    .fill(colorScheme == .light ? Color.blue.opacity(0.1) : .white)
                                    .frame(width: 50, height: 50)
                                    .overlay {
                                        Image(systemName: "plus")
                                            .imageScale(.large)
                                            .foregroundStyle(.blue)
                                    }
                                
                                Text("Add Favourite")
                            }
                        }
                        
                        
                        HStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                        .foregroundStyle(.white)
                                }
                            
                            Text("ENTER PAYBILL NUMBER")
                                .font(.headline)
                                .foregroundStyle(.blue)
                                .onTapGesture {
                                    enterPaybill.toggle()
                                }
                        }
                        
                        HStack {
                            Circle()
                                .fill(.purple)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: "book")
                                        .foregroundStyle(.white)
                                }
                            
                            Text("BILL MANAGER")
                                .font(.headline)
                        }
                        
                        HStack {
                            Circle()
                                .fill(.cyan)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: "qrcode")
                                        .foregroundStyle(.white)
                                }
                            
                            Text("SCAN QR CODE")
                                .font(.headline)
                        }
                        
                        Text("FREQUENTS")
                        Frequents(circleName: "KP", name: "KPLC PREPAID")
                        Frequents(circleName: "AB", name: "ABSA BANK KENYA PL")
                        Frequents(circleName: "S", name: "SAFARICOM POST PAID")
                        
                        Text("POPULAR BILLS")
                        PopularBills(circleText: "KS", title: "kenya bureau of standards", textColor: .green)
                        PopularBills(circleText: "N", title: "NHIF", textColor: .green)
                        PopularBills(circleText: "CB", title: "Credit bank", textColor: .red)
                        PopularBills(circleText: "CK", title: "citibank n.a kenya", textColor: .blue)
                        PopularBills(circleText: "SB", title: "sbm bank", textColor: .cyan)
                        PopularBills(circleText: "V", title: "Viusasa", textColor: .red)
                        PopularBills(circleText: "KP", title: "KPLC POST PAID", textColor: .blue)
                        PopularBills(circleText: "N", title: "NSSF", textColor: .yellow)
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal)
            .sheet(isPresented: $enterPaybill, content: {
                BuyGoodsNumberPad(title: "PAY BILL", placeholder: "Pay Bill")
            })
        }
    }
}

#Preview {
    PayBill()
}

struct PopularBills: View {
    @Environment(\.colorScheme) var colorScheme
    var circleText: String
    var title: String
    var textColor: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(colorScheme == .dark ? .gray.opacity(0.8) : .gray )
                .frame(width: 40, height: 40)
                .overlay {
                    Text(circleText)
                        .foregroundStyle(textColor)
                    
                }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title.uppercased())
                Text("0000")
            }
        }
    }
}

struct TVandInternet: View {
    @Environment(\.dismiss) var dismiss
    @State private var search: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }

                    Spacer()
                    
                    Text("TV AND INTERNET")
                      
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray)
                            .frame(width: 60, height: 6)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.green)
                            .frame(width: 14, height: 6, alignment: .leading)
                            .offset(x: -23)
                    }
                }
                .padding(.top, 20)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                    
                    
                    TextField("Search TV & Internet", text: $search)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.gray.opacity(0.2))
                )
                PopularBills(circleText: "V", title: "Viusasa", textColor: .red)
                PopularBills(circleText: "GT", title: "GO tv", textColor: .green)
                PopularBills(circleText: "JL", title: "jamii telecummunication", textColor: .green)
                PopularBills(circleText: "D", title: "dstv", textColor: .red)
                PopularBills(circleText: "S", title: "safaricom home", textColor: .blue)
                PopularBills(circleText: "S", title: "show max", textColor: .cyan)
               
                PopularBills(circleText: "Z", title: "ZUku fiber", textColor: .blue)
                PopularBills(circleText: "S", title: "startimes", textColor: .purple)
            }
            .padding(.horizontal)
        }
    }
}

struct SafSlide: View {
    @Environment(\.dismiss) var dismiss
    @State private var search: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }

                    Spacer()
                    
                    Text("SAFARICOM")
                      
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray)
                            .frame(width: 60, height: 6)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.green)
                            .frame(width: 14, height: 6, alignment: .leading)
                            .offset(x: -23)
                    }
                }
                .padding(.top, 20)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                    
                    
                    TextField("Search safaricom", text: $search)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.gray.opacity(0.2))
                )
                PopularBills(circleText: "S", title: "safaricom postpaid", textColor: .green)
                PopularBills(circleText: "S", title: "safaricom home", textColor: .green)
            }
            .padding(.horizontal)
        }
    }
}

struct Electricity: View {
    @Environment(\.dismiss) var dismiss
    @State private var search: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }

                    Spacer()
                    
                    Text("ELECTRICITY")
                      
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray)
                            .frame(width: 60, height: 6)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.green)
                            .frame(width: 14, height: 6, alignment: .leading)
                            .offset(x: -23)
                    }
                }
                .padding(.top, 20)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                    
                    
                    TextField("Search electricity", text: $search)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.gray.opacity(0.2))
                )
                PopularBills(circleText: "KP", title: "KPLC POSTPAID", textColor: .blue)
                PopularBills(circleText: "D", title: "D.LIGHT", textColor: .green)
                PopularBills(circleText: "SP", title: "SOLAR PANDA", textColor: .blue)
                PopularBills(circleText: "SK", title: "SUN KING", textColor: .cyan)
                PopularBills(circleText: "MS", title: "M-KOPA SOLAR", textColor: .green)
                PopularBills(circleText: "KP", title: "KPLC PREPAID", textColor: .green)
            }
            .padding(.horizontal)
        }
    }
}
