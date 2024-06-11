//
//  Register.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 10/06/2024.
//

import SwiftUI

struct Register: View {
    let images = ["maasai", "zebra", "ele"]
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    ForEach(images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                
                
                VStack {
                    Text("M-PESA")
                        .font(.title)
                        .foregroundStyle(.green)
                    
                    Spacer()
                    Text("WELCOME TO THE M-PESA APP")
                        .font(.headline)
                        .foregroundStyle(.green)
                    Text("MADE JUST FOR YOU")
                        .font(.headline)
                        .foregroundStyle(.green)
                    
                    NavigationLink(destination: PhoneNumberEntryView()) {
                        Text("SIGN IN")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 280, height: 44)
                            .background(Color.green)
                            .cornerRadius(22)
                            .padding()
                    }
                }
                .navigationTitle("")
                .navigationBarBackButtonHidden()
            }
        }
    }
}
struct PhoneNumberEntryView: View {
    @State private var phoneNumber = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var navigateToOTP = false
    @FocusState var firstNameIsFocused: Bool
    @FocusState var secondNameIsFocused: Bool
    @FocusState var phoneNumberIsFocused: Bool
    @State private var showError: Bool = false
    @State private var firstNameError: Bool = false
    @State private var secondNameError: Bool = false
    @State private var phoneNumberError: Bool = false
    
    @State private var user: UserModel?
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                    Text("Please fill in the required fields")
                        .foregroundColor(.red)
                        .opacity(showError ? 1 : 0)

                TextField("First name", text: $firstName)
                    .padding()
                    .keyboardType(.default)
                    .background(firstNameError ? Color.red.opacity(0.1) : Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
                    .focused($firstNameIsFocused)
                    .onSubmit {
                        secondNameIsFocused = true
                    }
                    .onChange(of: firstName) { _, _ in
                        if firstName.count != 1 {
                            firstNameError = false
                        }
                    }

                TextField("Second name", text: $lastName)
                    .padding()
                    .keyboardType(.default)
                    .background(secondNameError ? Color.red.opacity(0.1) : Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
                    .focused($secondNameIsFocused)
                    .onSubmit {
                        phoneNumberIsFocused = true
                    }
                    .onChange(of: lastName) { oldValue, newValue in
                        if lastName.count != 1 {
                            secondNameError = false
                        }
                    }

                TextField("Phone number", text: $phoneNumber)
                    .padding()
                    .keyboardType(.phonePad)
                    .background(phoneNumberError ? Color.red.opacity(0.1) : Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
                    .focused($phoneNumberIsFocused)
                    .onChange(of: phoneNumber) { oldValue, newValue in
                        if phoneNumber.count != 1 {
                            phoneNumberError = false
                        }
                    }

                Button {
                    validateFields()
                    if !firstNameError && !secondNameError && !phoneNumberError {
                        Task {
                            do {
                                user = UserModel(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, mpesaBalance: 0)
                                try await FirebaseAuth.instance.sendVerificationCode(for: phoneNumber)
                                
                                navigateToOTP = true
                            } catch {
                                print("Failed to send verification code: \(error.localizedDescription)")
                            }
                        }
                    }
                } label: {
                    Text("SIGN IN")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 280, height: 44)
                        .background(Color.green)
                        .cornerRadius(22)
                        .padding()
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                firstNameIsFocused = true
            }
            .navigationDestination(isPresented: $navigateToOTP) {
                OTPView(user: user ?? UserModel(firstName: "Hussein", lastName: "Aisak", phoneNumber: "12345678", mpesaBalance: 0))
            }
        }
    }
    
    private func validateFields() {
        showError = false
        firstNameError = firstName.isEmpty
        secondNameError = lastName.isEmpty
        phoneNumberError = phoneNumber.isEmpty

        if firstNameError || secondNameError || phoneNumberError {
            showError = true
        }
    }
}

#Preview {
//    Register()
    PhoneNumberEntryView()
}
