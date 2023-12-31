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
    @State private var favorites: Set<UUID> = []
    @State private var refreshID = UUID()
    @State var userId: String
    @State private var selectedMealType: String = "🍳"
    let mealTypes: [(String, String)] = [
        ("Breakfast", "🍳"),
        ("Lunch", "🥪"),
        ("Dinner", "🍲"),
        ("Snack", "🍿"),
        ("Teatime", "☕"),
        ("Italian", "🍝"),
        ("Chinese", "🥢"),
        ("Korean", "🇰🇷"),
        ("Japanese", "🍣"),
        ("Vietnamese", "🍜"),
        ("Thai", "🍛"),
        ("Burger", "🍔")
    ]

    private var gridView: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        return LazyVGrid(columns: columns) {
            ForEach(viewModel.images) { image in
                NavigationLink(destination: ImageDetailPage(imageModel: image, userId: userId)) {
                    ImageView(userId: userId, imageModel: image, imageURL: image.imageURL, title: image.label)
                        .cornerRadius(10)
                        .padding(8)
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                
                MealTypeSelector(mealTypes: mealTypes, selectedMealType: $selectedMealType) { mealType in
                    viewModel.fetchRecipes(for: mealType)
                }
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        gridView
                            .id(refreshID)
                    }
                    .refreshable {
                        viewModel.fetchRandomImages()
                    }
                    .onChange(of: searchText) { refreshID = UUID() }
                }
                .navigationTitle("Meal Plans")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search food...")
                .onChange(of: searchText) {
                    if searchText.isEmpty {
                        viewModel.fetchRandomImages()
                    } else {
                        viewModel.fetchRecipes(for: searchText)
                    }
                }
            }
        }
    }
    
    private func favoriteBinding(for id: UUID) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.favorites.contains(id) },
            set: { isFavorite in
                if isFavorite {
                    self.favorites.insert(id)
                } else {
                    self.favorites.remove(id)
                }
            }
        )
    }
}

#Preview {
    HomeView(userId: "sample")
}
