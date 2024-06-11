//
//  GlobalPayView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import SwiftUI
import Combine

struct GlobalPayView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var globalVM = GlobalVM()
    @State var showCardDetails: Bool = false
    @State private var currencyAmount: Double = 0
    @State private var convertedAmount: Double = 0
    @State private var selectCurrency: Bool = false
    @State private var humbugerMenu: Bool = false
    @State private var changeColor: Bool = false
    @State private var budget: Bool = false
    @State private var showMonthlyPopup: Bool = false
    @State private var showDisableGlobalPayPop: Bool = false
    @State private var showRepeatPayments: Bool = false
    @State private var showSuspendCard: Bool = false
    
    @State private var chosenCurrency: String = "USD"
    @State private var chosenCurrencyValue: Double = 0.01
    
    
    
    // track card flip state
    let durationDelay: CGFloat = 0.2
    @State var frontDegree: Double = 0
    @State var backDegree: Double = 90
    
    // timer that hides card details after a certain time
    @State private var timerSubscription: AnyCancellable?
    @State private var count: Int = 10
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ZStack {
                        VStack {
                            Image(systemName: "line.3.horizontal")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.bottom, 10)
                                .onTapGesture {
                                    humbugerMenu.toggle()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            visaCard
                            seeDetailsButton
                            exchangeRate
                            
                            // togles
                            VStack(spacing: 14) {
                                bugdetToggle
                                
                                if globalVM.budgetAmount != 0 && globalVM.setBugdet == true {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 8)
                                    
                                    HStack {
                                        Text("KES 0")
                                            .foregroundStyle(.green)
                                        
                                        Spacer()
                                        
                                        Text("KES \(String(format: "%.0f", globalVM.budgetAmount))")
                                        
                                        Text("Edit")
                                            .foregroundStyle(.green)
                                            .onTapGesture {
                                                showMonthlyPopup.toggle()
                                            }
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                }
                                
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 2)
                                
                                repeatPaymentsToggle
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 2)
                                
                                activateCardToggle
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 2)
                            }
                            
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 30)
                            
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Text("GlobalPay")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            
                            ToolbarItemGroup(placement: .topBarTrailing) {
                                Image(systemName: "xmark.circle")
                                    .onTapGesture {
                                        dismiss()
                                    }
                            }
                        }
                        .sheet(isPresented: $humbugerMenu, content: {
                            GlobalIndent(humbuger: $humbugerMenu) {
                                changeColor.toggle()
                            }
                            .presentationDetents([.fraction(0.4)])
                        })
                        .fullScreenCover(isPresented: $changeColor) {
                            EditCard(degree: $frontDegree, changeColor: $changeColor)
                                .navigationBarBackButtonHidden()
                        }
                        .fullScreenCover(isPresented: $budget) {
                            Budget(globalVM: globalVM, budget: $budget)
                        }
                        .fullScreenCover(isPresented: $showRepeatPayments) {
                            RepeatPayments(showRepeatPayments: $showRepeatPayments)
                        }
                        .onChange(of: globalVM.setBugdet) {
                            self.budget = globalVM.navigateToBudget()
                        }
                        .onChange(of: globalVM.repeatPayments) {
                            self.showRepeatPayments = globalVM.showRepeatPayments()
                        }
                        .onChange(of: globalVM.activateCard) {
                            self.showSuspendCard = globalVM.showSuspend()
                        }
                        .sheet(isPresented: $showMonthlyPopup, content: {
                            MonthlyBudget(globalVM: globalVM, editBudget: {
                                self.budget.toggle()
                            }, disableGlobalPay: {
                                withAnimation(.bouncy) {
                                    self.showMonthlyPopup.toggle()
                                    self.showDisableGlobalPayPop.toggle()
                                }
                            })
                            .presentationDetents([.fraction(0.3)])
                        })
                        .sheet(isPresented: $showSuspendCard, content: {
                            SuspendCard {
                                self.showSuspendCard.toggle()
                            }
                            .presentationDetents([.fraction(0.4)])
                        })
                        .fullScreenCover(isPresented: $selectCurrency, content: {
                            CurrencyList(chosenCurrency: $chosenCurrency, chosenCurrencyValue: $chosenCurrencyValue, dismiss: $selectCurrency)
                        })
                        .blur(radius: showDisableGlobalPayPop ? 4 : 0)
                        
                        RoundedRectangle(cornerRadius: 15)
                        .fill(.white.opacity(0.9))
                        .frame(height: 180)
                        .overlay {
                        VStack(alignment: .leading, spacing: 20) {
                        Text("Disable monthly budget".uppercased())
                        .fontWeight(.bold)
                        Text("You are about to disable Monthly budget. Do you still want to continue? You can activate it later")
                        
                        HStack(spacing: 20) {
                        Spacer()
                        Text("CANCEL")
                        .onTapGesture {
                        showDisableGlobalPayPop.toggle()
                        }
                        
                        Text("DISABLE")
                        .foregroundStyle(.red)
                        .onTapGesture {
                        globalVM.setBugdet.toggle()
                        showDisableGlobalPayPop.toggle()
                        }
                        }
                        .font(.headline)
                        .padding(.trailing)
                        }
                        .padding(.horizontal)
                        }
                        .padding(.horizontal)
                        .opacity(showDisableGlobalPayPop ? 1 : 0)
                    }
                    .onAppear {
                        globalVM.resetBudgetToggle()
                    }
                }
                .preferredColorScheme(.light)
                .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}



#Preview {
    GlobalPayView()
}


// MARK: Views
extension GlobalPayView {
    private var visaCard: some View {
        VStack {
            CardView(globalVM: globalVM, frontDegree: $frontDegree, backDegree: $backDegree)
                .padding(.horizontal)
        }
        .frame(width: 350, height: 220)
    }
    
    private var seeDetailsButton: some View {
        HStack {
            ZStack {
                Text("\(count)")
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(
                        Circle()
                            .stroke(Color.white, lineWidth: 1.0) )
                    .opacity(showCardDetails ? 1 : 0)
                Image(systemName: "eye")
                    .opacity(showCardDetails ? 0 : 1)
            }
            Text(showCardDetails ? "Hide Card Details" : "See Card Details")
        }
        .font(.headline)
        .foregroundStyle(.white)
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 250, height: 55)
        )
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 24)
        .frame(width: 250, height: 55)
        .frame(maxWidth: .infinity, alignment: .center)
        .onTapGesture {
            if showCardDetails {
                hideCardDetailsFunc()
            } else {
                showCardDetailsFunc()
            }
        }
    }
    
    private var exchangeRate: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Cost estimator")
                    .font(.headline)
                Spacer()
                Text("1 \(chosenCurrency) = KSH \(String(format: "%.2f", 1 / chosenCurrencyValue))")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }

                HStack {
                    HStack {
                        Text("USD")
                        Image(systemName: "arrowtriangle.down.fill")
                    }
                    .frame(width: 100, height: 30)
                    .background(.blue.opacity(0.2))
                    .onTapGesture {
                        selectCurrency.toggle()
                    }
                    
                    
                    TextField("", value: $currencyAmount, format: .number)
                        .padding(.leading, 50)
                }
                .frame(height: 30)
                .background(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1.0)
                }
                .onChange(of: currencyAmount) {
                    self.convertedAmount = currencyAmount * chosenCurrencyValue
                }
        

            HStack(spacing: 0) {
                Image(systemName: "arrow.up")
                Image(systemName: "arrow.down")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Text("KSH")
                    .frame(width: 100, height: 30)
                    .background(.blue.opacity(0.2))
                Text("\(String(format: "%.2f", convertedAmount))")
                    .padding(.leading, 50)
                TextField("", value: $currencyAmount, format: .number)
                    .offset(x: 60)
                    .opacity(0)
                
            }
            .frame(height: 30)
            .background(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1.0)
            }
        }
        .frame(height: 120)
        .padding()
        .background(.blue.opacity(0.15))
        .cornerRadius(10)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    private var bugdetToggle: some View {
        HStack {
            Image("payLoan")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(8)
                .background(
                    Circle()
                        .stroke(.black, lineWidth: 1.0)
                )
            
            VStack(alignment: .leading) {
                Text("Set budget")
                Text("Track your spend")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            
            Toggle("", isOn: $globalVM.setBugdet)
                .frame(width: 40)
        }
    }
    
    private var repeatPaymentsToggle: some View {
        HStack {
            Image(systemName: "arrow.triangle.2.circlepath")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(8)
                .background(
                    Circle()
                        .stroke(.gray, lineWidth: 1.0)
                )
            
            VStack(alignment: .leading) {
                Text("Enable Repeat Payments")
                Text("Pay for your subscription")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Toggle("", isOn: $globalVM.repeatPayments)
                .frame(width: 40)
        }
    }
    
    private var activateCardToggle: some View {
        HStack {
            Image(systemName: "nosign")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(8)
                .background(
                    Circle()
                        .stroke(.gray, lineWidth: 1.0)
                )
            
            VStack(alignment: .leading) {
                Text("Block Card")
                Text("Temporarily block card")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Toggle("", isOn: $globalVM.activateCard)
                .frame(width: 40)
        }
    }
}



// MARK: FUNCTIONS
extension GlobalPayView {
    func showCardDetailsFunc() {
        showCardDetails = true
        withAnimation(.default) {
            frontDegree = -90
        }
        withAnimation(.default) {
            backDegree = 0
        }
        startTimer()
    }
    
    func hideCardDetailsFunc() {
        showCardDetails = false
        withAnimation(.default) {
            backDegree = 90
        }
        withAnimation(.default) {
            frontDegree = 0
        }
        cancelTimer()
    }
    
    func flipCard() {
        if showCardDetails {
            withAnimation(.default) {
                backDegree = 90
            }
            withAnimation(.default) {
                frontDegree = 0
            }
        } else {
            withAnimation(.default) {
                frontDegree = -90
            }
            withAnimation(.default) {
                backDegree = 0
            }
        }
    }
    
    func startTimer() {
        timerSubscription?.cancel()
        count = 10
        timerSubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if count > 0 {
                    count -= 1
                } else {
                    hideCardDetailsFunc()
                }
            }
    }
    
    func cancelTimer() {
        timerSubscription?.cancel()
        count = 10
    }
}

/*

 */
