//
//  MainTab.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 27/05/2024.
//

import SwiftUI

@MainActor
class MainEntry: ObservableObject {
    @Published var isUserAuthenticated: Bool = false
    @Published var showPinView: Bool = false
    
    func authUser(reason: String) async {
        isUserAuthenticated = await LocalAuth.shared.authenticateWithBiometrics(reason: reason)
    }
}

struct MainTab: View {
    @StateObject private var vm = MainEntry()
    var user: UserModel
    
    var body: some View {
        ZStack {
            if vm.isUserAuthenticated { // <- face id auth
                TabView {
                    Home(user: user)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    TransactView()
                        .tabItem {
                            Label("Transact", systemImage: "arrow.left.arrow.right")
                        }
                    
                    ServicesView()
                        .tabItem {
                            Label("Services", systemImage: "list.triangle")
                        }
                    
                    Grow()
                        .tabItem {
                            Label("Grow", systemImage: "chart.bar.xaxis.ascending.badge.clock")
                        }
                }
                .tint(.green)
                .fontWeight(.bold)
                .onAppear {
                    Task {
//                        await DatabaseService.instance.callOnLaunch()
                    }
                }
            } else {
                Login(authState: $vm.isUserAuthenticated)
            }
        }
    }
}

#Preview {
    MainTab(user: UserModel(firstName: "Hussein", lastName: "Aisak", phoneNumber: "12345678", mpesaBalance: 0))
}
