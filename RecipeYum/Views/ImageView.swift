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
            ZStack(alignment: .bottomTrailing){
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
                Button(action: {
                    self.isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite == true ? "heart.fill" : "heart")
                        .padding(4)
                        .foregroundColor(isFavorite == true ? .red : .gray)
                .buttonStyle(PlainButtonStyle())
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))

                .background(Color.white.opacity(0.7))
                .cornerRadius(20)
                .offset(y:-10)
                }
            }
            if let title = title {
                Text(title)
                    .font(.caption)
                    .lineLimit(1)
            }
        }
    }
}

