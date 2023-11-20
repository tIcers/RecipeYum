//
//  ImageListViewModel.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import Foundation
import Combine

class ImageListViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var searchString: String = ""

    private var cancellables: Set<AnyCancellable> = []
    private let appId = "f2f45e95"
    private let appKey = "b72dc6cc95bcc5c2731e9880f4436877"
    private let apiEndpoint = "https://api.edamam.com/api/recipes/v2"

    func fetchRecipes(for query: String) {
        let parameters: [String: String] = [
            "q": query,
            "app_id": appId,
            "app_key": appKey,
            "type": "public"
        ]

        guard let url = URL(string: apiEndpoint + "?" + parameters.urlEncodedString) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EdamamAPIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching recipes: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.images = response.hits.map { hit in
                    ImageModel(
                        imageURL: URL(string: hit.recipe.image)!,
                        label: hit.recipe.label,
                        calories: hit.recipe.calories,
                        shareAs: hit.recipe.shareAs,
                        cuisineType: hit.recipe.cuisineType,
                        mealType: hit.recipe.mealType,
                        dietLabels: hit.recipe.dietLabels,
                        healthLabels: hit.recipe.healthLabels,
                        ingredients: hit.recipe.ingredientLines,
                        fat: hit.recipe.totalNutrients.FAT.quantity,
                        carbs: hit.recipe.totalNutrients.CHOCDF.quantity,
                        protein: hit.recipe.totalNutrients.PROCNT.quantity
                    )
                }
            })
            .store(in: &cancellables)
    }
    func fetchRandomImages() {
        let randomQueries = ["chicken", "pasta", "salad", "dessert"]
        let randomQuery = randomQueries.randomElement() ?? "chicken"

        fetchRecipes(for: randomQuery)
    }}

