//
//  ServicesView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 03/06/2024.
//

import SwiftUI

struct ServicesView: View {
    @State private var selection: selection = .financial
    @State private var showService: Bool = false
    var column: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 20) {
                            VStack {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "banknote")
                                            .rotationEffect(Angle(degrees: -50))
                                    }
                                Text("Bill Manager")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            
                            VStack {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "building.columns")
                                    }
                                Text("Financial Services")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                selection = .financial
                                showService.toggle()
                            }
                            
                            VStack {
                                Circle()
                                    .fill(.orange)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "basket.fill")
                                    }
                                Text("Shop & Gift")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                selection = .shop
                                showService.toggle()
                            }
                            
                            VStack {
                                Circle()
                                    .fill(.red)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "water.waves")
                                            .rotationEffect(Angle(degrees: -50))
                                    }
                                Text("Public Sector")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                selection = .publicSector
                                showService.toggle()
                            }
                            
                            VStack {
                                Circle()
                                    .fill(.green.opacity(0.5))
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "banknote")
                                    }
                                Text("Get Insurance")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            
                            VStack {
                                Circle()
                                    .fill(.purple)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "bus")
                                    }
                                Text("Transport & Travel")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            
                            VStack {
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "gear")
                                    }
                                Text("Utilities")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            
                            VStack {
                                Circle()
                                    .fill(.pink)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "banknote")
                                    }
                                Text("Loans & Credit")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            
                            VStack {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Text("S")
                                    }
                                Text("My Safaricom")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                selection = .mySaf
                                showService.toggle()
                            }
                            
                            VStack {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                       Image(systemName: "graduationcap")
                                    }
                                Text("Education")
                                    .font(.subheadline)
                            }
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Text("FREQUENTS")
                        .font(.headline)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            RoundedComponent(
                                imageText: "M-Shwari",
                                title: "M-SHWARI",
                                textColor: .white,
                                backgroundColor: .green,
                                imageName: "",
                                isText: true
                            )
                            
                            RoundedComponent(
                                imageText: "KCB",
                                title: "KCB M-PESA",
                                textColor: .white,
                                backgroundColor: .blue,
                                imageName: "",
                                isText: true
                            )
                            
                            RoundedComponent(
                                imageText: "RATIBA",
                                title: "MPESA RATIBA",
                                textColor: .white,
                                backgroundColor: .green,
                                imageName: "",
                                isText: true
                            )
                            RoundedComponent(
                                imageText: "G",
                                title: "GLOBAL PAY",
                                textColor: .white,
                                backgroundColor: .blue,
                                imageName: "",
                                isText: true
                            )
                            
                            RoundedComponent(
                                imageText: "",
                                title: "BOOK A FLIGHT",
                                textColor: .primary,
                                backgroundColor: .primary,
                                imageName: "airplane",
                                isText: false
                            )
                            
                        }
                    }
                    
                    Text("DISCOVER MORE")
                        .font(.headline)
                    LazyVGrid(columns: column, content: {
                        RoundedComponent(
                            imageText: "GiftPesa",
                            title: "Buy Gift",
                            textColor: .white,
                            backgroundColor: .red,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "MAJi",
                            title: "MAJIAPP",
                            textColor: .blue,
                            backgroundColor: .gray.opacity(0.4),
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "ezawadi",
                            title: "EZAWADI",
                            textColor: .white,
                            backgroundColor: .pink,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "M-SOKO",
                            title: "Safaricom M-soko",
                            textColor: .white,
                            backgroundColor: .green,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "MYCOUNTY",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "kenya",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "MYNAIROBI",
                            textColor: .white,
                            backgroundColor: .primary,
                            imageName: "nairobi",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "Hustler Fund",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "hustler",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "NHIF",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "nhif",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "Marine Cargo",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "cruise",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "PRUDENTIAL",
                            title: "PRUDENTIAL",
                            textColor: .red,
                            backgroundColor: .gray.opacity(0.4),
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "Insureme",
                            title: "INSUREME",
                            textColor: .white,
                            backgroundColor: .pink,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "Kenbright",
                            title: "Kenbright",
                            textColor: .orange,
                            backgroundColor: .blue,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "BOOK A FLIGHT",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "airplane",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "TRIPS",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "trips",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "SGR",
                            textColor: .primary,
                            backgroundColor: .pink,
                            imageName: "sgr",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "IABIRI APP",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "bus",
                            isText: false
                        )
                        RoundedComponent(
                            imageText: "",
                            title: "SHell club",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "shell",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "MDAKTARI",
                            textColor: .red,
                            backgroundColor: .primary,
                            imageName: "nurse",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "Prudential",
                            title: "Prudential",
                            textColor: .primary,
                            backgroundColor: .gray,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "HEALTH INSURANCE",
                            textColor: .primary,
                            backgroundColor: .gray,
                            imageName: "heart",
                            isText: false
                        )
                        
                        
                        RoundedComponent(
                            imageText: "",
                            title: "SASADOCTOR",
                            textColor: .primary,
                            backgroundColor: .gray,
                            imageName: "healthcare",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "anga",
                            title: "movies",
                            textColor: .black,
                            backgroundColor: .gray,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "mookh",
                            title: "MOOKH",
                            textColor: .white,
                            backgroundColor: .yellow,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "team",
                            title: "TEAM TRAVEL",
                            textColor: .red,
                            backgroundColor: .gray.opacity(0.2),
                            imageName: "",
                            isText: true
                        )
                        
                        
                        RoundedComponent(
                            imageText: "malipo",
                            title: "MALIPOEXPERIENC",
                            textColor: .white,
                            backgroundColor: .pink,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "M-PESA RATIBA",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "calendar",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "SAFARICOM BUNDLES",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "slogo",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "ask zuri",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "assistant",
                            isText: false
                        )
                        
                        
                        RoundedComponent(
                            imageText: "M-SOKO",
                            title: "SAFARICOM M-SOKO",
                            textColor: .white,
                            backgroundColor: .green,
                            imageName: "",
                            isText: true
                        )
                        
                        RoundedComponent(
                            imageText: "",
                            title: "helb",
                            textColor: .primary,
                            backgroundColor: .primary,
                            imageName: "helb",
                            isText: false
                        )
                        
                        RoundedComponent(
                            imageText: "Kodris",
                            title: "KODRIS AFRICA",
                            textColor: .primary,
                            backgroundColor: .orange,
                            imageName: "",
                            isText: true
                        )
                        
                    })
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 20)
                }
                .padding(.horizontal)
                .navigationTitle("SERVICES")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Image(systemName: "magnifyingglass")
                }
                .navigationDestination(isPresented: $showService) {
                    ServiceSheet(title: "", selection: selection)
                        .navigationBarBackButtonHidden()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ServicesView()
}
