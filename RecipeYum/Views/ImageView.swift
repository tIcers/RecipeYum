//
//  ImageView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL

    let foodName: String
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFill()
            case .empty:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
            @unknown default:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(height: 100)
        Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .offset(x: 20, y: -20)
                        .padding(.trailing, -20)
                    
        Text(foodName)
                        .foregroundColor(.black)
                        .font(.footnote)
                        .padding(.top, 5)
    }
}
