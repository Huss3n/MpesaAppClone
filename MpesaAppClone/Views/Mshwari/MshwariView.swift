//
//  MshwariView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 04/06/2024.
//

import SwiftUI

struct MshwariView: View {
    @ObservedObject var mshwariBalance = MpesaBalance.instance
    @Namespace private var namespace
    @Environment(\.dismiss) var dismiss
    @State private var showBalance: Bool = false
    @State private var date: Date = Date()
    @State private var selection: selections = .deposit
    @State private var loan: Bool = false
    @State private var isLoadingState: Bool = false
    @State private var safariView: Bool = false
    @State private var deposit: Bool = false
    @State private var withdraw: Bool = false
    
    // handles the loan and pay state
    @State var settings: Bool = false
    @State var navigate: Bool = false
    @State var reqPay: ReqPayPath = .loan
    
    let availableLimit: Double = 14_000
    
    
    // setting trim for the  cirlce percentage
    var loanPercentage: Double {
        mshwariBalance.loanBalance / availableLimit
    }
    
    enum selections {
        case deposit
        case lock
        case loan
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isLoadingState {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(Color("mshwariColor"))
                            .frame(height: 250)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 10) {
                            HStack {
                                Image(systemName: "house")
                                    .padding(.trailing, 10)
                                Text("M-Shwari")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(.white.opacity(0.5))
                                    .frame(width: 100, height: 30)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "ellipsis")
                                                .onTapGesture {
                                                    settings.toggle()
                                                }
                                            Spacer()
                                            Image(systemName: "xmark.circle")
                                                .onTapGesture {
                                                    dismiss()
                                                }
                                        }
                                        .font(.title2)
                                        .padding(.horizontal, 14)
                                        .fontWeight(.medium)
                                    }
                            }
                            
                            Text("SAVINGS BALANCE")
                                .foregroundStyle(.white)
                                .fontWeight(.light)
                                .padding(.top, 30)
                            
                            HStack {
                                if showBalance {
                                    Rectangle()
                                        .fill(.ultraThinMaterial)
                                        .cornerRadius(10)
                                        .frame(width: 140)
                                } else {
                                    Text("KSH. \( mshwariBalance.mshwariBalance.formatted(.number.precision(.fractionLength(2)).grouping(.automatic)))")
                                        .font(.title2)
                                        .fontWeight(.light)
                                        .opacity(showBalance ? 0 : 1)
                                }
                                Image(systemName: showBalance ? "eye" : "eye.slash")
                                    .onTapGesture {
                                        showBalance.toggle()
                                    }
                            }
                            .foregroundStyle(.white)
                            .frame(height: 40)
                            .padding(.top, -6)
                            
                            
                            // MARK: LOCK SAVINGS
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(height: 120)
                                .shadow(radius: 8)
                                .overlay {
                                    HStack(alignment: .center, spacing: 20) {
                                        Circle()
                                            .stroke(Color.blue, lineWidth: 1.0)
                                            .frame(width: 50, height: 50)
                                            .overlay {
                                                Text("0%")
                                                    .foregroundStyle(.purple)
                                            }
                                        
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("LOCK SAVINGS")
                                                    .font(.subheadline)
                                                    .fontWeight(.light)
                                                Spacer()
                                                
                                                Text("KSH 0.00")
                                                    .fontWeight(.regular)
                                            }
                                            
                                            HStack {
                                                Text("TARGET AMOUNT")
                                                    .foregroundStyle(.gray)
                                                    .font(.subheadline)
                                                    .fontWeight(.light)
                                                Spacer()
                                                Text("KSH 0.00")
                                                    .foregroundStyle(.gray)
                                                    .fontWeight(.light)
                                            }
                                            Text("Maturity Date")
                                                .foregroundStyle(.gray)
                                                .font(.subheadline)
                                                .fontWeight(.light)
                                        }
                                        
                                        Image(systemName: "greaterthan")
                                            .fontWeight(.regular)
                                    }
                                    .padding(.horizontal)
                                }
                            
                            // MARK: LOAN AMOUNT
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(height: 120)
                                .shadow(radius: 8)
                                .overlay {
                                    HStack(alignment: .center, spacing: 20) {
                                        if loanPercentage == 0 {
                                            Circle()
                                                .stroke(Color.gray.opacity(0.4), lineWidth: 2.0)
                                                .rotationEffect(.degrees(-90))
                                                .frame(width: 50, height: 50)
                                                .overlay {
                                                    Text("\(Int(loanPercentage * 100))%")
                                                        .foregroundStyle(.green)
                                                }
                                        } else {
                                            Circle()
                                                .trim(from: 0, to: loanPercentage)
                                                .stroke(Color.green, lineWidth: 2.0)
                                                .rotationEffect(.degrees(-90))
                                                .frame(width: 50, height: 50)
                                                .overlay {
                                                    Text("\(Int(loanPercentage * 100))%")
                                                        .foregroundStyle(.green)
                                                }
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("LOAN AMOUNT")
                                                    .font(.subheadline)
                                                    .fontWeight(.light)
                                                Spacer()
                                                
                                                Text("KSH. \( mshwariBalance.loanBalance.formatted(.number.precision(.fractionLength(2)).grouping(.automatic)))")
                                                    .fontWeight(.regular)
                                            }
                                            
                                            HStack {
                                                Text("AVAILABLE LIMIT")
                                                    .foregroundStyle(.gray)
                                                    .font(.subheadline)
                                                    .fontWeight(.light)
                                                Spacer()
                                                Text("KSH. \(availableLimit.formatted(.number.precision(.fractionLength(2)).grouping(.automatic)))")
                                                    .font(.caption)
                                                    .foregroundStyle(.gray)
                                                    .fontWeight(.light)
                                            }
                                            
                                            HStack {
                                                Text("Due date")
                                                    .foregroundStyle(.gray)
                                                    .font(.subheadline)
                                                    .fontWeight(.light)
                                                Spacer()
                                                //Text("\(date)")
                                                // .foregroundStyle(.gray)
                                                // .fontWeight(.light)
                                            }
                                        }
                                        
                                        Image(systemName: "greaterthan")
                                            .fontWeight(.regular)
                                    }
                                    .padding(.horizontal)
                                }
                                .onTapGesture {
                                    loan.toggle()
                                }
                            
                            HStack(spacing: 50) {
                                VStack(alignment: .center) {
                                    Image(systemName: "arrowshape.down.fill")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(.green)
                                        .clipShape(Circle())
                                    
                                    Text("DEPOSIT FROM")
                                    Text("M-PESA")
                                }
                                .fontDesign(.monospaced)
                                .onTapGesture {
                                    deposit.toggle()
                                }
                                
                                VStack(alignment: .center) {
                                    Image(systemName: "arrowshape.up.fill")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(.red)
                                        .clipShape(Circle())
                                    
                                    Text("WITHDRAW TO")
                                    Text("M-PESA")
                                }
                                .fontDesign(.monospaced)
                                .onTapGesture {
                                    withdraw.toggle()
                                }
                            }
                            .padding(.top, 30)
                            
                            
                            HStack(alignment: .top) {
                                Text("DEPOSIT")
                                    .font(.subheadline)
                                    .foregroundStyle(selection == .deposit ? .white : .black)
                                    .padding(8)
                                    .background(selection == .deposit ? .green : .clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .onTapGesture {
                                        withAnimation(.bouncy) {
                                            selection = .deposit
                                        }
                                    }
                                
                                Text("LOCK SAVINGS")
                                    .font(.subheadline)
                                    .foregroundStyle(selection == .lock ? .white : .black)
                                    .padding(8)
                                    .padding(.horizontal)
                                    .background(selection == .lock ? .green : .clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .onTapGesture {
                                        withAnimation(.bouncy) {
                                            selection = .lock
                                        }
                                    }
                                
                                Text("LOAN")
                                    .font(.subheadline)
                                    .foregroundStyle(selection == .loan ? .white : .black)
                                    .padding(8)
                                    .padding(.horizontal)
                                    .background(selection == .loan ? .green : .clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .onTapGesture {
                                        withAnimation(.bouncy) {
                                            selection = .loan
                                        }
                                    }
                                
                            }
                            .padding(.top, 20)
                            
                            ScrollView {
                                VStack {
                                    if selection == .deposit {
                                        ContentUnavailableView("", systemImage: "book.pages", description: Text("No deposit records availavle"))
                                    } else if selection == .lock {
                                        ContentUnavailableView("", systemImage: "book.pages", description: Text("No lock savings records availavle"))
                                    } else {
                                        ContentUnavailableView("", systemImage: "book.pages", description: Text("No loan transaction records availavle"))
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .sheet(isPresented: $settings, content: {
                            SettingsTop(settings: $settings,safariView: $safariView, callToAction: { loadingComplete() })
                                .presentationDetents([.fraction(0.3)])
                        })
                        .sheet(isPresented: $loan, content: {
                            LoanTop(loan: $loan, reqPay: $reqPay, navigate: $navigate)
                                .presentationDetents([.fraction(0.2)])
                        })
                        .sheet(isPresented: $safariView, content: {
                            safari()
                        })
                        .fullScreenCover(isPresented: $navigate) {
                            ReqPay(reqPay: $reqPay, navigate: $navigate)
                                .navigationBarBackButtonHidden()
                        }
                        .toolbar(.hidden, for: .tabBar)
                        .fullScreenCover(isPresented: $deposit) {
                            DepWithMshwari(isDeposit: true, deposit: $deposit)
                                .navigationBarBackButtonHidden()
                        }
                        .fullScreenCover(isPresented: $withdraw) {
                            DepWithMshwari(deposit: $withdraw)
                                .navigationBarBackButtonHidden()
                        }
                    }
                    
                } else {
                    // remove aftter fetching data
                    MshwariLoading()
                }
            }
            .onAppear {
                loadingComplete()
            }
            .preferredColorScheme(.light)
        }
    }
    
    private func loadingComplete() {
        self.isLoadingState = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut) {
                self.isLoadingState = true
            }
        }
    }
}

#Preview {
    MshwariView()
}


