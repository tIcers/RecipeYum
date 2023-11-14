//
//  SearchView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-11-13.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = ImageListViewModel()
    @State private var favorites: Set<UUID> = []

    var body: some View {
        VStack {
            TextField("Search Recipes", text: $viewModel.searchString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Search") {
                viewModel.fetchRecipes(for: viewModel.searchString)
            }
            .padding()

            List(viewModel.images, id: \.id) { imageModel in
                HStack {
                    ImageView(
                        imageURL: imageModel.imageURL,
                        title: imageModel.label,
                        isFavorite: .constant(favorites.contains(imageModel.id))
                    )
                    .onTapGesture {
                        if favorites.contains(imageModel.id) {
                            favorites.remove(imageModel.id)
                        } else {
                            favorites.insert(imageModel.id)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(imageModel.label)
                    }
                }
            }
        }
    }
}



#Preview {
    SearchView()
}
