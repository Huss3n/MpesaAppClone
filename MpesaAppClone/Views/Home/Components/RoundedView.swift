//
//  RoundedView.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 28/05/2024.
//

import SwiftUI

struct RoundedView: View {
    @Environment(\.colorScheme) var colorScheme
    var componentTitle: String
    var height: CGFloat
    @Binding var viewALL: Bool
    @Binding var selection: selection
    var viewAllPressed: () -> ()
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(colorScheme == .light ? .white : .gray.opacity(0.15))
                    .shadow(radius: 1)
                    .frame(height: height)
                
                HStack {
                    Text(componentTitle)
                        .foregroundStyle(.primary)
                        .font(.headline)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text("View All")
                        .foregroundStyle(.green)
                        .onTapGesture {
                            viewAllPressed()
                        }
                }
                .padding(.top, 8)
                .padding()
            }
        }
    }
}

#Preview {
//    RoundedView(viewALL: .constant(true), selection: .constant(.financial))
//    RoundedView(
//        componentTitle: "Financial Services",
//        height: 150,
//        viewALL: .constant(true),
//        selection: .constant(.financial)) {
//            
//        }
    RoundedComponent(
        imageText: "MǍLI",
        title: "MALI",
        textColor: .white,
        backgroundColor: .primary,
        imageName: "calendar",
        isText: false
    )
}

struct RoundedComponent: View {
    var imageText: String
    var title: String
    var textColor: Color
    var backgroundColor: Color
    var imageName: String = ""
    
    var isText: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 17) {
            Circle()
                .fill(backgroundColor.opacity(0.8))
                .frame(width: 50, height: 50)
                .overlay {
                    if isText {
                        Text(imageText)
                            .font(.caption)
                            .foregroundStyle(textColor)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .lineLimit(4)
                    } else {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                            .overlay {
                                Circle()
                                    .stroke(backgroundColor, lineWidth: 0.3)
                            }
                    }
                }
            
            Text(title.uppercased())
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .font(.subheadline)
        .fontWeight(.light)
    }
}


struct RoundedRec: View {
    @Environment(\.colorScheme) var colorScheme
    var height: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(colorScheme == .light ? .white : .gray.opacity(0.15))
            .shadow(radius: 1)
            .frame(height: height)
    }
}

