//
//  Home.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 27/05/2024.
//

import SwiftUI
import PhotosUI

struct Home: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @State private var showBalance: Bool = false
    @State private var viewALL: Bool = false
    @State private var selection: selection = .financial
    @State private var transactionType: TransactionType = .sendMoney
    @State private var showTrnsactionType: Bool = false
    @State private var detentHeight: CGFloat = 0
    @State private var showStatements: Bool = false
    @State private var showNotifications: Bool = false
    @State private var showSpending: Bool = false
    @State var mainAction: MainAction = .send(.sendMoney)
    
    // access camera
    
    var body: some View {
        NavigationStack {
            VStack {
                topView
                ScrollView {
                    balanceView
                        .padding(.bottom, 12)
                    
                    transactionButtons
                        .padding(.bottom, 12)
                    
                    mpesaStatements
                    ImageCarousel()
                    
                    // services
                    VStack(spacing: 24) {
                        // MARK: Finacial services
                        financialServices

                       // MARK: Shop and gift
                        shopAndGift
                       
                        // MARK: Public sector
                        publicSector
                     
                        // MARK: GET INSURANCE
                        getInsurance
                        
                        // MARK: Transport and Travel
                        transportAndTravel
                        
                        // MARK: Reward and Royalty
                        rewardAndLoyalty
                        
                        // MARK: Health and wellness
                        healthAndWellness
                        
                        // MARK: Events and expiriences
                        eventsAndExpiriences
                        
                        // MARK: My safaricom
                        mySafaricom
                        
                        // MARK: Education
                        education
                        
                        // MARK: News and entertainment
                        newsAndEntertainment
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 20)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 6)
            .sheet(isPresented: $viewALL, content: {
                ServiceSheet(title: "", selection: selection)
            })
            .sheet(isPresented: $showTrnsactionType,
                   content: {
                TransactionButtonPressed(
                    detentHeight: $detentHeight,
                    transactionType: transactionType,
                    mainAction: mainAction
                )
            })
            .navigationDestination(isPresented: $showStatements) {
                Statements()
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
    func pathToTake() {
        
    }
    
    func getDetentHeight(_ transaction: TransactionType) -> CGFloat {
        if transaction == .sendMoney {
            return 0.45
        } else if transaction == .pay {
            return 0.55
        } else if transaction == .withdraw {
            return 0.4
        } else {
            return 0.4
        }
    }
}

#Preview {
    Home()
}


extension Home {
    // MARK: topView
    private var topView: some View  {
        HStack(spacing: 14) {
            PhotoPicker()
                .frame(width: 60, height: 60)
                .onTapGesture {
                    // choose photo
                }
            
            VStack(alignment: .leading) {
                Text("Good Morning")
                    .fontWeight(.light)
                Text("Hussein 👋")
                    .fontWeight(.heavy)
            }
            .padding(.leading, -18)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            Image(systemName: "bell")
                .imageScale(.large)
            
            
            Image(systemName: "chart.pie")
                .rotationEffect(Angle(degrees: -130))
                .imageScale(.large)
            
            Image(systemName: "qrcode.viewfinder")
                .imageScale(.large)
        }
    }
    
    
    // MARK: Balance view
    private var balanceView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(colorScheme == .light ? .white : .gray.opacity(0.15))
                .shadow(radius: 1)
                .frame(height: 120)
                .overlay {
                    ZStack(alignment: .top) {
                        Text("Balance")
                            .fontWeight(.light)
                            .padding(.top, 6)
                        
                        VStack(alignment: .center) {
                            Text("Ksh. \(String(format: "%.2f", mpesaBalance.mpesaBalance))")
                                .font(.title)
                                .fontWeight(.light)
                            Text("Available FULIZA: KSH 8000.00")
                                .fontWeight(.light)
                                .foregroundStyle(.blue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .padding(.horizontal, 20)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .blur(radius: showBalance ? 6 : 0)
                    }
                    Image(systemName: showBalance ? "eye" : "eye.slash")
                        .offset(x: 100, y: -10)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                showBalance.toggle()
                            }
                        }
                }
        }
    }
    
    
    // MARK: Transaction buttons
    private var transactionButtons: some View {
        HStack(alignment: .top, spacing: 24) {
            VStack(alignment: .center) {
                Image(systemName: "arrow.left.arrow.right")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .rotationEffect(Angle(degrees: -50))
                    .padding(10)
                    .background(Color("sendColor"))
                    .clipShape(Circle())
                
                Text("SEND AND ")
                Text("REQUEST")
            }
            .onTapGesture {
                showTrnsactionType.toggle()
                transactionType = .sendMoney
                self.detentHeight = getDetentHeight(.sendMoney)
            }
            
            
            VStack(alignment: .center) {
                Image("pay")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .padding(10)
                    .background(Color("payColor"))
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                
                Text("PAY")
            }
            .onTapGesture {
                showTrnsactionType.toggle()
                transactionType = .pay
                self.detentHeight = getDetentHeight(.pay)
            }
            
            
            VStack(alignment: .center) {
                Image("withdraw")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .padding(10)
                    .background(Color("withdrawColor"))
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                
                Text("WITHDRAW")
            }
            .onTapGesture {
                showTrnsactionType.toggle()
                transactionType = .withdraw
                self.detentHeight = getDetentHeight(.withdraw)
            }
            
            VStack(alignment: .center) {
                Image("airtime")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .padding(10)
                    .background(Color("airtimeColor"))
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                
                Text("AIRTIME")
            }
            .onTapGesture {
                showTrnsactionType.toggle()
                transactionType = .airtime
                self.detentHeight = getDetentHeight(.airtime)
            }
        }
        .font(.subheadline)
        .fontWeight(.light)
    }
    
    // MARK: Statements
    private var mpesaStatements: some View {
        Group {
            HStack(alignment: .top, spacing: 6) {
                Text("M-PESA STATEMENTS")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("SEE ALL")
                    .foregroundStyle(.green)
                    .font(.headline)
                    .onTapGesture {
                        showStatements.toggle()
                    }
            }
            
            HStack {
                Circle()
                    .fill(.green.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text("HM")
                            .foregroundStyle(.green)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("HUSSEIN MUKTAR")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text("254712345678")
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text("-KSH. 3000.00")
                    Text("28 May, 10:20 AM")
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
                
            }
            .blur(radius: showBalance ? 6 : 0)
        }
    }
}

// MARK: Services
extension Home {
    private var financialServices: some View {
        RoundedView(
            componentTitle: "Financial Services",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
                viewALL.toggle()
                selection = .financial
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
                    RoundedComponent(
                        imageText: "MǍLI",
                        title: "MALI",
                        textColor: .white,
                        backgroundColor: .green,
                        imageName: "",
                        isText: true
                    )
                    
                    RoundedComponent(
                        imageText: "M-Shwari",
                        title: "M-SHWARI",
                        textColor: .white,
                        backgroundColor: .gray,
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
                }
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var shopAndGift: some View {
        RoundedView(
            componentTitle: "Shop & Gift",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
                viewALL.toggle()
                selection = .shop
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var publicSector: some View {
        RoundedView(
            componentTitle: "Public Sector",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
                viewALL.toggle()
                selection = .publicSector
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var getInsurance: some View {
        RoundedView(
            componentTitle: "Get Insurance",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
              
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var transportAndTravel: some View {
        RoundedView(
            componentTitle: "Transport & Travel",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
              // pass selection type and view all click
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var rewardAndLoyalty: some View {
        RoundedView(
            componentTitle: "Reward & Loyalty",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
              // pass selection type and view all click
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
                    RoundedComponent(
                        imageText: "",
                        title: "SHell club",
                        textColor: .primary,
                        backgroundColor: .primary,
                        imageName: "shell",
                        isText: false
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var healthAndWellness: some View {
        
        RoundedView(
            componentTitle: "Health & Awareness",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
              // pass selection type and view all click
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var eventsAndExpiriences: some View {
        
        RoundedView(
            componentTitle: "Events & Expiriences",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
              // pass selection type and view all click
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 52)
                .padding(12)
            }

    }
    
    private var mySafaricom: some View {
        
        RoundedView(
            componentTitle: "My Safaricom",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
                viewALL.toggle()
                selection = .mySaf
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var education: some View {
        
        RoundedView(
            componentTitle: "Education",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
              // pass selection type and view all click
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
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
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 52)
                .padding(12)
            }
    }
    
    private var newsAndEntertainment: some View {
        RoundedView(
            componentTitle: "Education",
            height: 165,
            viewALL: $viewALL,
            selection: $selection) {
              // pass selection type and view all click
            }
            .overlay {
                HStack(alignment: .top, spacing: 22) {
                    RoundedComponent(
                        imageText: "the standard",
                        title: "THE STANDARD",
                        textColor: .red,
                        backgroundColor: .white,
                        imageName: "",
                        isText: true
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 52)
                .padding(12)
            }
    }
}

