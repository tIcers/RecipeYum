//
//  ImageView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL

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
        .frame(height: 200)
    }
}
