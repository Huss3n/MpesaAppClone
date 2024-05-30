//
//  ServiceSheet.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 28/05/2024.
//

import SwiftUI

struct ServiceSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    
    var navTitle: String {
        if selection == .financial {
            return "FINANCIAL SERVICES"
        } else if selection == .publicSector {
            return "PUBLIC SECTOR"
        } else if selection == .shop {
            return "SHOP & GIFT"
        } else {
            return "MY SAFARICOM"
        }
    }
    
    var title: String
    var selection: selection
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search services", text: $searchText)
                    }
                    .padding(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray.opacity(0.2))
                    }
                    
                    if selection == .financial {
                        finacial
                    } else if selection == .publicSector {
                        publicSector
                    } else if selection == .shop {
                        shop
                    } else {
                        mySaf
                    }
                }
                .navigationTitle(navTitle.uppercased())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "xmark")
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ServiceSheet(
        title: "",
        selection: .mySaf
    )
}


enum selection {
    case financial
    case shop
    case publicSector
    case mySaf
}



extension ServiceSheet {
    private var finacial: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Circle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("MALI")
                            .foregroundStyle(.white)
                    }
                
                Text("MALI")
            }
            .fontWeight(.regular)
            
            HStack(alignment: .center) {
                Circle()
                    .fill(.white)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("MSHWARI")
                            .font(.caption)
                            .foregroundStyle(.green)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: 0.5)
                                    .frame(width: 50, height: 50)
                            )
                        
                    }
                
                Text("M-SHWARI")
            }
            
            HStack(alignment: .center) {
                Circle()
                    .fill(.blue)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("KCB")
                            .font(.caption)
                            .foregroundStyle(.white)
                        
                    }
                
                Text("KCB MPESA")
                
            }
            
            HStack(alignment: .center) {
                Circle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                    .overlay {
                       Image(systemName: "calendar")
                            .imageScale(.large)
                    }
                
                Text("M-PESA RATIBA")
                
            }
            
            HStack(alignment: .center) {
                Circle()
                    .fill(.orange)
                    .frame(width: 50, height: 50)
                    .overlay {
                       Image(systemName: "chart.bar.doc.horizontal")
                            .imageScale(.large)
                    }
                
                Text("FARAJA")
                
            }
            
            HStack(alignment: .center) {
                Circle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                    .overlay {
                       Image(systemName: "globe")
                            .imageScale(.large)
                    }
                
                Text("GLOBAL PAY")
                
            }
            
            HStack(alignment: .center) {
                Circle()
                    .fill(.blue)
                    .frame(width: 50, height: 50)
                    .overlay {
                       Image("airtime")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                
                Text("INTERNATIONAL AIRTIME")
                
            }
            
            HStack(alignment: .center) {
                Circle()
                    .fill(.white)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("GO")
                            .font(.caption)
                            .foregroundStyle(.green)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: 0.5)
                                    .frame(width: 50, height: 50)
                            )
                    }
                
                Text("MPESA GO")
            }
        }
        .font(.subheadline)
        .fontWeight(.light)
    }
    
    private var shop: some View {
        VStack(alignment: .leading) {
            HStack {
             Circle()
                    .fill(.pink)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("GIFTPesa")
                            .font(.caption2)
                    }
                
                Text("buy gift vouchers".uppercased())
            }
            
            HStack {
             Circle()
                    .fill(.white)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("MAJI")
                            .font(.caption2)
                            .foregroundStyle(.blue)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: 0.5)
                                    .frame(width: 50, height: 50)
                            )
                    }
                
                Text("maji app".uppercased())
            }
            
            
            HStack {
             Circle()
                    .fill(.purple)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("ezawadi")
                            .font(.caption2)
                            .foregroundStyle(.white)
                    }
                
                Text("ezawadi".uppercased())
            }
        }
        .font(.subheadline)
        .fontWeight(.light)
    }
    
    private var publicSector: some View {
        VStack(alignment: .leading, spacing: -20) {
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "kenya",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("MY COUNTY")
                    .padding(.bottom, 10)
            }
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "nairobi",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("MY NAIROBI")
                    .padding(.bottom, 10)
            }
            
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "hustler",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("HUSTLER FUND")
                    .padding(.bottom, 10)
            }
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "nhif",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("MY NHIF")
                    .padding(.bottom, 10)
            }
            
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "helb",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("HELB")
                    .padding(.bottom, 10)
            }
        }
        .font(.subheadline)
        .fontWeight(.light)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var mySaf: some View {
        VStack(alignment: .leading, spacing: -20) {
            HStack(alignment: .center) {
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .frame(width: 50, height: 50)
                    .background(.green)
                    .clipShape(Circle())
                    .foregroundStyle(.white)
                    .overlay {
                        Circle()
                            .stroke(.black, lineWidth: 0.3)
                    }
                    .padding(.top, 18)
                
                Text("M-PESA RATIBA")
                    .padding(.top, 18)
            }
            .padding(.bottom, 16)
            
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "slogo",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("SAFARICOM BUNDLES")
                    .padding(.bottom, 10)
            }
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "assistant",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("ASK ZURI")
                    .padding(.bottom, 10)
            }
            .padding(.top, -10)
            .padding(.bottom, -10)
            
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "M-SOKO",
                    title: "",
                    textColor: .white,
                    backgroundColor: .green,
                    imageName: "",
                    isText: true
                )
                .padding(.top, 18)
                
                Text("SAFARICOM MASOKO")
                    .padding(.bottom, 10)
            }
            .padding(.bottom, -10)
            
            HStack(alignment: .center) {
                RoundedComponent(
                    imageText: "",
                    title: "",
                    textColor: .primary,
                    backgroundColor: .primary,
                    imageName: "sHome",
                    isText: false
                )
                .padding(.top, 18)
                
                Text("SAFARICOM HOME")
                    .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
