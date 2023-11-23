//
//  ImageView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL
    let title: String?
    @Binding var isFavorite: Bool

    var body: some View {
        VStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure, .empty:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    Text("Unknown Image Phase")
                }
            }
            .frame(height: 200)
            .cornerRadius(10)

            if let title = title {
                Text(title)
                    .font(.caption)
                    .lineLimit(1)
            }

            Button(action: {
                self.isFavorite.toggle()
            }) {
                Image(systemName: isFavorite == true ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite == true ? .red : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 2)
            .opacity(isFavorite != nil ? 1 : 0) 
        }
    }
}

