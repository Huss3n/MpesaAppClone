//
//  ColorTheme.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 13/06/2024.
//

import SwiftUI

struct ColorTheme: View {
    @Binding var colorScheme: ColorScheme
    @Binding var chooseTheme: Bool

    @State private var isSelectedLight: Bool = false
    @State private var isSelectedDark: Bool = false
    @State private var isSelectedSystem: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text("SELECT THEME")
                .font(.headline)
                .padding(.horizontal)
                .offset(y: 40)

            HStack(spacing: 40) {
                VStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 50, height: 80)
                 
                    Text("LIGHT")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(.top, 8)
                    
                    Circle()
                        .fill(isSelectedLight ? Color.green : Color.clear)
                        .overlay(
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .opacity(isSelectedLight ? 1 : 0)
                        )
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .onTapGesture {
                    isSelectedLight.toggle()
                    isSelectedDark = false
                    isSelectedSystem = false
                    colorScheme = .light
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        chooseTheme.toggle()
                    }
                }

                VStack {
                    Rectangle()
                        .fill(Color.black.opacity(0.8))
                        .frame(width: 50, height: 80)
                    
                    Text("DARK")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(.top, 8)
                    
                    Circle()
                        .fill(isSelectedDark ? Color.green : Color.clear)
                        .overlay(
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .opacity(isSelectedDark ? 1 : 0)
                        )
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .onTapGesture {
                    isSelectedDark.toggle()
                    isSelectedLight = false
                    isSelectedSystem = false
                    colorScheme = .dark
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        chooseTheme.toggle()
                    }
                }

                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 50, height: 80)
                        
                        Rectangle()
                            .fill(Color.black.opacity(0.8))
                            .frame(width: 25, height: 80)
                            .offset(x: 12)
                    }
                    
                    Text("SYSTEM")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(.top, 8)
                    
                    Circle()
                        .fill(isSelectedSystem ? Color.green : Color.clear)
                        .overlay(
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .opacity(isSelectedSystem ? 1 : 0)
                        )
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .onTapGesture {
                    isSelectedSystem.toggle()
                    isSelectedLight = false
                    isSelectedDark = false
                    colorScheme = .light // Assuming .system is represented by .light, change if needed
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        chooseTheme.toggle()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.4))
        .onAppear {
            updateSelection()
        }
    }
    
    // Update the selection state based on the initial color scheme
    private func updateSelection() {
        switch colorScheme {
        case .light:
            isSelectedLight = true
            isSelectedDark = false
            isSelectedSystem = false
        case .dark:
            isSelectedLight = false
            isSelectedDark = true
            isSelectedSystem = false
        default:
            isSelectedLight = false
            isSelectedDark = false
            isSelectedSystem = true
        }
    }
}

struct ColorTheme_Previews: PreviewProvider {
    static var previews: some View {
        ColorTheme(colorScheme: .constant(.light), chooseTheme: .constant(true))
    }
}

