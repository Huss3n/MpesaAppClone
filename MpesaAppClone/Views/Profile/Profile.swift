//
//  Profile.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 10/06/2024.
//

import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var user: UserModel
    @Published var photosPickerItem: PhotosPickerItem?

    
    init(user: UserModel) {
        self.user = user
    }
    
    func updatePhoto() async {
        guard let photosPickerItem else { return }
        do {
            let data = try await photosPickerItem.loadTransferable(type: Data.self)
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.user.image = image
                }
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
}

struct Profile: View {
    @StateObject private var vm: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    @State private var appearance: Bool = false
    @State private var biometricAuth: Bool = true
    @State private var fastlogin: Bool = false
    @State private var showPopUp: Bool = false
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    @State private var preferedColorScheme: ColorScheme = .light
    @State private var chooseTheme: Bool = false
    
    init(user: UserModel) {
        _vm = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("ACCOUNT")
                            .foregroundStyle(.primary)
                            .font(.title)
                            .fontWeight(.light)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack {
                            if let selectedImage = vm.user.image {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } else {
                                PhotoPicker()
                                    .frame(width: 80, height: 80)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(vm.user.firstName)
                                    .font(.headline)
                                Text(vm.user.phoneNumber)
                                    .fontWeight(.light)
                            }
                            Spacer()
                            
                            PhotosPicker(selection: $vm.photosPickerItem, matching: .images) {
                                Text("EDIT PICTURE")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .padding(6)
                                    .background(
                                        Capsule()
                                            .stroke(Color.primary, lineWidth: 1.0)
                                    )
                            }
                            .tint(.primary)
                            .onChange(of: vm.photosPickerItem) { _, _ in
                                Task {
                                    await vm.updatePhoto()
                                }
                            }
                        }
                        
                        HStack(alignment: .top, spacing: 40) {
                            VStack(spacing: 4) {
                                Image(systemName: "briefcase")
                                    .foregroundStyle(.primary)
                                    .font(.title)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.gray.opacity(0.2))
                                            .frame(width: 80, height: 50)
                                    )
                                
                                Text("M-Pesa Staements")
                            }
                            
                            VStack(spacing: 4) {
                                Image(systemName: "book.pages")
                                    .foregroundStyle(.primary)
                                    .font(.title)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.gray.opacity(0.2))
                                            .frame(width: 80, height: 50)
                                    )
                                
                                Text("M-Pesa Staements")
                            }
                            
                            VStack(spacing: 4) {
                                Image(systemName: "chart.pie.fill")
                                    .foregroundStyle(.primary)
                                    .font(.title)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.gray.opacity(0.2))
                                            .frame(width: 80, height: 50)
                                    )
                                
                                Text("My Spend")
                            }
                        }
                        
                        Text("SETTINGS")
                            .font(.headline)
                        
                        TransactionCatgoryComponent(
                            name: "MANAGE FAVORITES",
                            imageName: "star",
                            backgroundColor: .pink
                        )
                        
                        TransactionCatgoryComponent(
                            name: "share app link",
                            imageName: "link",
                            backgroundColor: .blue
                        )
                        
                        TransactionCatgoryComponent(
                            name: "blocked business",
                            imageName: "link",
                            backgroundColor: .red
                        )
                        
                        TransactionCatgoryComponent(
                            name: "appearance",
                            imageName: appearance ? "sun.min" : "moon",
                            backgroundColor: appearance ? .yellow : .gray
                        )
                        .onTapGesture {
                            chooseTheme.toggle()
                        }
                        
                        TransactionCatgoryComponent(
                            name: "log out",
                            imageName: "arrow.right.to.line.alt",
                            backgroundColor: .cyan
                        )
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                showPopUp.toggle()
                            }
                        }
                        
                        Text("SECURITY")
                            .font(.headline)
                        
                        
                        HStack {
                            TransactionCatgoryComponent(
                                name: "Biometric authentication",
                                imageName: "faceid",
                                backgroundColor: .green
                            )
                            
                            Toggle("", isOn: $biometricAuth)
                                .frame(width: 40)
                        }
                        
                        
                        HStack {
                            TransactionCatgoryComponent(
                                name: "fast login",
                                imageName: "lock.fill",
                                backgroundColor: .indigo
                            )
                            
                            Toggle("", isOn: $fastlogin)
                                .frame(width: 10)
                        }
                        
                        TransactionCatgoryComponent(
                            name: "change pin",
                            imageName: "lock.fill",
                            backgroundColor: .mint
                        )
                        
                        Text("SUPPORT")
                            .font(.headline)
                        
                        TransactionCatgoryComponent(
                            name: "call support",
                            imageName: "phone",
                            backgroundColor: .pink
                        )
                        
                        TransactionCatgoryComponent(
                            name: "faqs",
                            imageName: "book",
                            backgroundColor: .teal
                        )
                        
                        Link(destination: URL(string: "www.safaricom.co.ke")!) {
                            TransactionCatgoryComponent(
                                name: "search website",
                                imageName: "globe",
                                backgroundColor: .green
                            )
                        }
                        .tint(.primary)
                        
                    }
                    .padding(.horizontal)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(systemName: "arrow.left")
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                    }
                    .sheet(isPresented: $showPopUp) {
                        LogoutPop(logout: {
                            print("on start \(userLoggedIn.description)")
                            showPopUp.toggle()
                            dismiss()
                            DispatchQueue.main.async {
                                userLoggedIn = false
                            }
                            print("on end \(userLoggedIn.description)")
                            if !userLoggedIn {
                                Task.init {
                                    await FirebaseAuth.instance.logout()
                                }
                            }
                        }, showPopUp: $showPopUp)
                        .presentationDetents([.fraction(0.3)])
                    }
                    .sheet(isPresented: $chooseTheme) {
                        ColorTheme(colorScheme: $preferedColorScheme, chooseTheme: $chooseTheme)
                            .presentationDetents([.fraction(0.3)])
                    }
                    .preferredColorScheme(preferedColorScheme)
                }
            }
            
        }
    }
}

#Preview {
    Profile(user: UserModel(firstName: "Hussein", lastName: "Aisak", phoneNumber: "12345678", mpesaBalance: 0))
}


struct LogoutPop: View {
    @Environment(\.colorScheme) var colorScheme
    var logout: () -> ()
    @Binding var showPopUp: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("LOG OUT")
                .font(.headline)
            
            Text("You are about to logout from this device clearing all transaction frequents. To use this device, you will have to sign in again")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            
            Text("LOG OUT")
                .font(.headline)
                .foregroundStyle(.red)
                .onTapGesture {
                    withAnimation(.easeOut) { logout() }
                }
            
            Rectangle()
                .fill(.gray)
                .frame(height: 2)
            
            Text("CANCEL")
                .font(.headline)
                .onTapGesture {
                    showPopUp.toggle()
                }
        }
        .background(colorScheme == .light ? .white : .black)
        .foregroundStyle(colorScheme == .light ? .black : .white)
        .toolbar(.hidden, for: .tabBar)
        .padding(.horizontal)
    }
}
