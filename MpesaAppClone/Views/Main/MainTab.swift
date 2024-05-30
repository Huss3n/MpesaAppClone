//
//  MainTab.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 27/05/2024.
//

import SwiftUI

struct MainTab: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            Text("Transact")
                .tabItem {
                    Label("Transact", systemImage: "arrow.left.arrow.right")
                }
            
            Text("Services")
                .tabItem {
                    Label("Services", systemImage: "list.triangle")
                }
            
            Text("Grow")
                .tabItem {
                    Label("Grow", systemImage: "chart.bar.xaxis.ascending.badge.clock")
                }
        }
        .tint(.green)
        .fontWeight(.bold)
    }
}

#Preview {
    MainTab()
}
