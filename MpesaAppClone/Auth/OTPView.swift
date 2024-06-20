//
//  OTPView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 11/06/2024.
//

import SwiftUI

struct OTPView: View {
    @State private var otp: String = ""
    @FocusState private var isOTPFieldFocused: Bool
    @State private var timerValue: Int = 60
    @State private var timer: Timer?
    @State private var error: String = ""
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    
    var user: UserModel
    
    var body: some View {
        VStack {
            Text("SIGN IN ON M-PESA")
                .font(.title)
                .padding(.top, 50)
            
            Text("Please enter the OTP code sent to \(user.phoneNumber).")
                .padding()
            
            TextField("- - - - - -", text: $otp)
                .font(.title)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .focused($isOTPFieldFocused)
                .onAppear {
                    isOTPFieldFocused = true
                    startTimer()
                }
                .onChange(of: isOTPFieldFocused) { _, newValue in
                    if newValue {
                        startTimer()
                    } else {
                        stopTimer()
                    }
                }
                .padding()
            
            Text(error)
                .opacity(error.count > 0 ? 1 : 0)
            
            Button {
                Task {
                    print("START: \(userLoggedIn.description)")
                    do {
                        try await FirebaseAuth.instance.verifyUserCode(verificationCode: otp) { success, authData in
                            print("Success \(success.description)")
                            DispatchQueue.main.async {
                                userLoggedIn = success
                            }
                            print("AFTER SUCCESS: \(userLoggedIn.description)")
                        }
                        if userLoggedIn {
                            try await DatabaseService.instance.saveUserData(user: user)
                            try await DatabaseService.instance.saveRequestState()
                        }
                        
                    } catch {
                        self.error = error.localizedDescription
                        print("Failed to verify code: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Verify")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(Color.green)
                    .cornerRadius(22)
                    .padding()
            }
            
            Text("Resend your code if it doesn't arrive in \(timerValue)s")
                .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
    
    private func startTimer() {
        timerValue = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timerValue > 0 {
                timerValue -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView(user: UserModel(firstName: "Hussein", lastName: "Aisak", phoneNumber: "12345678", mpesaBalance: 0))
    }
}
