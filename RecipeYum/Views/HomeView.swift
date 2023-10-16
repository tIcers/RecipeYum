//
//  HomeView.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-06.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ImageListViewModel()
    var body: some View {
            NavigationView {
                List(viewModel.images) { image in
                    NavigationLink(destination: ImageDetailPage(imageURL: image.imageURL)) {
                        ImageView(imageURL: image.imageURL)
                            .cornerRadius(10)
                            .padding(8)
                    }
                }
                .navigationTitle("Recipes for you!")
                .onAppear {
                    viewModel.fetchRandomImages()
                }
            }
        }
    }

#Preview {
    HomeView()
}