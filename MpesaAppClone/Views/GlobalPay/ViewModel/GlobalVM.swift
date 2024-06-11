//
//  GlobalVM.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 05/06/2024.
//

import Foundation
import SwiftUI

class GlobalVM: ObservableObject {
    @AppStorage("backgroundSelected") var backgroundSelected: String = ""
    @AppStorage("backgroundColor") var backgroundColor: String = ""
    @AppStorage("imageOrColor") var imageOrColor: Bool = false // true -> color false -> image
    
    let cardImages: [String] = ["elephant", "lion", "waterfall", "savanah", "mountain"]
    let cardColors: [String] = ["color1", "color2","color3", "color4", "color5"]
    
    @Published var starterBackground: String = "elephant"
    @Published var starterColor: String = "color1"
  
    // currency conversion
    @Published var selectedCurrency: String = ""
    
    //keeping track of toggle buttons
    @Published var setBugdet: Bool = false
    @Published var repeatPayments: Bool = false
    @Published var activateCard: Bool = false
    
    @Published var budgetAmount: Double = 0
    
    
    init() { }
    
    func navigateToBudget() -> Bool {
        return setBugdet
    }
    
    func showSuspend() -> Bool {
        return activateCard
    }
    
    func showRepeatPayments() -> Bool {
        return repeatPayments
    }
    
    func updateBackgroundColor(newColor: String) {
        UserDefaults.standard.set(newColor, forKey: "backgroundColor")
        UserDefaults.standard.set(true, forKey: "imageOrColor")
    }
    
    func updateBackgroundImage(newImage: String) {
        UserDefaults.standard.set(newImage, forKey: "backgroundSelected")
        UserDefaults.standard.set(false, forKey: "imageOrColor")
    }
    
    // update budget amount
    func updateBudgetAmount(amount: Double) {
        self.budgetAmount = amount
    }
    
    func resetBudgetToggle() {
        if budgetAmount < 100 {
            setBugdet = false
        }
    }
    
}
