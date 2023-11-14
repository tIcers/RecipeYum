//
//  HomeView.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-06.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ImageListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images) { image in
                        NavigationLink(destination: ImageDetailPage(imageModel: image)) {
                            ImageView(imageURL: image.imageURL)
                                .cornerRadius(10)
                                .padding(8)
                        }
                    }
                }
            }
            .navigationTitle("Today's Meals")
            .searchable(text: $searchText, prompt: "Search food...")
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    viewModel.fetchRandomImages()
                } else {
                    viewModel.fetchRecipes(for: newValue)
                }
            }
            .onAppear {
                if searchText.isEmpty {
                    viewModel.fetchRandomImages()
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
