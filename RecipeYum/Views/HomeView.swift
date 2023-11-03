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
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images) { image in
                        NavigationLink(destination: ImageDetailPage(imageURL: image.imageURL)) {
                            ImageView(imageURL: image.imageURL)
                                .cornerRadius(10)
                                .padding(8)
                        }
                    }
                }
                .navigationTitle("Today's Meals")
                .onAppear {
                    viewModel.fetchRandomImages()
                }
            }
            .searchable(text: $searchText, prompt: "Search food...")
        }
    }
}

#Preview {
    HomeView()
}
