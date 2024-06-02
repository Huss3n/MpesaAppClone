//
//  SendRequest.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 29/05/2024.
//

// display contacts here

import SwiftUI
import UIKit
import Contacts

struct SendRequest: View {
    @State private var contacts: [Contact] = []
    @Environment(\.dismiss) var dismiss
    @State private var search: String = ""
    @Environment(\.colorScheme) var colorScheme
    @Binding var path: SendOrRequest
    @State private var enterPhoneNumber: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                topComponent
                searchBar
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        addToFav
                        HStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                        .foregroundStyle(.white)
                                }
                            
                            Text("ENTER PHONE NUMBER")
                                .font(.headline)
                                .foregroundStyle(.blue)
                                .onTapGesture {
                                    enterPhoneNumber.toggle()
                                }
                        }
                        circularButtons
                        
                        Text("FREQUENTS")
                        // list the contacts below
                        ForEach(contacts) { contactDetail in
                            NavigationLink {
                                AmountView(contact: contactDetail, sendOrRequest: path)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    Circle()
                                        .fill(.gray.opacity(0.4))
                                        .frame(width: 40, height: 40)
                                        .overlay {
                                            Text(contactDetail.initials)
                                                .fontWeight(.light)
                                        }
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(contactDetail.givenName)
                                            Text(contactDetail.familyName)
                                        }
                                        Text(contactDetail.mobileNumber ?? "")
                                    }
                                    .font(.subheadline)
                                }
                            }
                            .tint(.primary)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .scrollIndicators(.hidden)
            }
            .onAppear {
                Task.init {
                    await getContactList()
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .sheet(isPresented: $enterPhoneNumber) {
                NumericPad(sendOrRequest: path)
            }
        }
    }
    
    // MARK: Get contact details
    func getContactList() async {
        // create the store
        let CNStore = CNContactStore()
        
        // specify the keys you want to fetch
        let keys = [CNContactGivenNameKey,CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
        
        // create a fetch request
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        // call the method to fetch all contacts
        do {
            try CNStore.enumerateContacts(with: request) { contact, _ in
                var mobileNumber: String? = nil
                
                for number in contact.phoneNumbers {
                    if number.label == CNLabelPhoneNumberMobile {
                        mobileNumber = number.value.stringValue
                        break
                    }
                }
                
                if let mobile = mobileNumber {
                    let newContact = Contact(
                        givenName: contact.givenName,
                        familyName: contact.familyName,
                        mobileNumber: mobile
                    )
                    DispatchQueue.main.async {
                        contacts.append(newContact)
                    }
                }
            }
        } catch {
            print("error fetching contacts: \(error.localizedDescription)")
        }
    }
}


#Preview {
    SendRequest(path: .constant(.send))
}



extension SendRequest {
    private var topComponent: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "xmark")
                .imageScale(.large)
                .onTapGesture {
                    dismiss()
                }
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.gray.opacity(0.6))
                    .frame(width: 230, height: 40)
                    .overlay {
                        HStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(path == .send ? Color.gray.opacity(0.8) : Color.gray.opacity(0))
                                .frame(height: 40)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay {
                                    Text("SEND")
                                        .font(.subheadline)
                                }
                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        path = .send
                                    }
                                }
                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(path == .send ? Color.gray.opacity(0) : Color.gray.opacity(0.8))
                                .frame(height: 40)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .overlay {
                                    Text("REQUEST")
                                        .font(.subheadline)
                                }
                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        path = .request
                                    }
                                }
                        }
                        .foregroundStyle(.white)
                    }
            }
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.gray)
                    .frame(width: 60, height: 6)
                
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.green)
                    .frame(width: 14, height: 6, alignment: .leading)
                    .offset(x: -23)
            }
        }
        .padding(.top, 16)
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)
            
            
            TextField("Search Contacts", text: $search)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.gray.opacity(0.3))
        )
    }
    
    private var addToFav: some View {
        VStack {
            Circle()
                .fill(colorScheme == .light ? Color.blue.opacity(0.1) : .white)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundStyle(.blue)
                }
            
            Text("Add Favourite")
        }
    }
    
    private var circularButtons: some View {
        Group {
            if path == .send {
                HStack {
                    Circle()
                        .fill(.green)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "person.3.sequence.fill")
                                .foregroundStyle(.white)
                        }
                    
                    Text("SEND TO MANY")
                        .font(.headline)
                }
                HStack {
                    Circle()
                        .fill(.cyan)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "qrcode")
                                .foregroundStyle(.white)
                        }
                    
                    Text("SCAN QR CODE")
                        .font(.headline)
                }
            } else {
                HStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "person.badge.clock.fill")
                                .foregroundStyle(.white)
                        }
                    
                    Text("M-PESA REQUESTS(0)")
                        .font(.headline)
                }
            }
        }
    }
}
