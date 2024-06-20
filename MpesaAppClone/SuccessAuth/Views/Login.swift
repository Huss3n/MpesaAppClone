//
//  Login.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 10/06/2024.
//

import SwiftUI

struct Login: View {
    @State private var pin = ""
    @State private var isVerifying = false
    @State private var isPinCorrect = false
    @Binding var authState: Bool
    
    let correctPin = "1234"  // Example correct PIN
    
    var name: String = "John Doe"
    var phoneNumber: String = "(234) 567 8999"
    var body: some View {
        VStack {
            VStack {
                PhotoPicker()
                    .frame(width: 120, height: 120)
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(phoneNumber)
            }
            .font(.headline)
            
            Spacer()
            Spacer()
            
            Text("ENTER M-PESA PIN")
            
            HStack(spacing: 20) {
                ForEach(0..<4) { index in
                    Circle()
                        .stroke(lineWidth: 1)
                        .background(Circle().fill(self.fillColor(for: index)))
                        .frame(width: 40, height: 40)
                        .opacity(isVerifying ? 0.5 : 1)
                        .animation(
                            isVerifying ? Animation.default.repeatForever(
                                autoreverses: true
                            ) : .default
                        )
                }
            }
            
            Spacer()
            
            KeypadView(pin: $pin, onSubmit: verifyPin)
                .disabled(isVerifying)
        }
        .padding()
        .onAppear {
            Task {
                let biometryType = LocalAuth.shared.getBiometryType()
                authState = await LocalAuth.shared.authenticateWithBiometrics(reason:"Biometrics needed for authentication")
            }
        }
    }
    
    private func fillColor(for index: Int) -> Color {
        if index < pin.count {
            return isPinCorrect ? .green : .green
        }
        return Color.clear
    }
    
    private func verifyPin() {
        guard pin.count == 4 else { return }
        
        isVerifying = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isPinCorrect = self.pin == self.correctPin
            self.isVerifying = false
            
            if self.isPinCorrect {
                // Handle successful PIN entry
                withAnimation(.easeIn) {
                    authState.toggle()
                }
            } else {
                // Handle incorrect PIN entry
                self.pin = ""
            }
        }
    }
    
}

#Preview {
    Login(authState: .constant(true))
}
