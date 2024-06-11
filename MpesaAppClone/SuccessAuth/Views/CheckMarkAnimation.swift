//
//  CheckMarkAnimation.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 09/06/2024.
//

import SwiftUI
struct CheckMarkAnimation: View {
    @State private var drawPercentage1: CGFloat = 1
    @State private var drawPercentage2: CGFloat = 1
    @State private var drawCircle: CGFloat = 0
    var lineWidth: CGFloat = 3
    var markScale: CGFloat = 0.7
    
    var startAnimation: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: drawCircle)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 80 * markScale, height: 80 * markScale) // Adjusted size of the circle
                .rotationEffect(.degrees(-50))
                .padding() // Add padding to create space between the circle and checkmark
            
            Group {
                Path { path in
                    path.move(to: CGPoint(x: 45 * markScale, y: 55 * markScale )) // Adjusted position for centering
                    path.addLine(to: CGPoint(x: 55 * markScale, y: 70 * markScale )) // Adjusted position for centering
                }
                .trim(from: 0, to: drawPercentage1)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                
                Path { path in
                    path.move(to: CGPoint(x: 55 * markScale, y: 70 * markScale )) // Adjusted position for centering
                    path.addLine(to: CGPoint(x: 85 * markScale, y: 40 * markScale )) // Adjusted position for centering
                }
                .trim(from: 0, to: drawPercentage2)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            }
        }
        .foregroundStyle(.green)
        .frame(width: 10 * markScale, height: 100 * markScale)
        .onAppear(perform: {
            if startAnimation {
                animate()
            }
        })
    }
    
    func animate() {
        drawPercentage1 = 0
        drawPercentage2 = 0
        drawCircle = 0
        
        withAnimation(.easeInOut(duration: 0.3)) {
            drawPercentage1 = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.5)) {
                drawPercentage2 = 1.5
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut(duration: 0.6)) {
                drawCircle = 1.0
            }
        }
    }
}

#Preview {
    CheckMarkAnimation(startAnimation: true)
}
