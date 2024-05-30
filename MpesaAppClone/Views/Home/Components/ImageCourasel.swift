//
//  ImageCourasel.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 28/05/2024.
//

import SwiftUI


struct ImageCarousel: View {
    let slideImages: [String] = ["pic1", "pic2", "pic3", "pic4", "pic5"]
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    @State private var selectedImageIndex: Int = 0
    
    
    var body: some View {
        VStack {
            VStack {
                // Display the current image
                Image(slideImages[selectedImageIndex])
                    .resizable()
//                    .scaledToFit()
                    .frame(height: 200)
                    .transition(.slide) // Add transition effect (slide from right to left)
            .onReceive(timer) { _ in
                // Increment index to move to the next image
                selectedImageIndex = (selectedImageIndex + 1) % slideImages.count
            }
        }
            // Display small circles indicating the position of the current image
            HStack {
                ForEach(0..<slideImages.count, id: \.self) { index in
                    Circle()
                        .fill(index == selectedImageIndex ? Color.red : Color.gray)
                        .frame(width: 10, height: 10)
                        .padding(.horizontal, 5)
                }
            }
            .padding()
        }
    }
}
#Preview {
    ImageCarousel()
}
