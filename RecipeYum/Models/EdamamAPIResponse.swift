//
//  EdamamAPIResponse.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import Foundation

struct EdamamAPIResponse: Decodable {
    let hits: [Hit]

    struct Hit: Decodable {
        let recipe: Recipe

        struct Recipe: Decodable {
            // recipe name
            let label: String
            // image url
            let image: String
            // edamam recipe site
            let shareAs: String
            // i.e. "low-carb"
            let dietLabels: [String]
            // i.e. "Diary-free"
            let healthLabels: [String]
            // an array of ingredients
            let ingredientLines: [String]
            let calories: Double
            // a string array of cuisine type
            let cuisineType: [String]
            // i.e. lunch/dinner
            let mealType: [String]
            let totalNutrients: Nutrient
            
            struct Nutrient: Decodable {
                let FAT: Fat
                let CHOCDF: Carbs
                let PROCNT: Protein
                
                struct Fat: Decodable {
                    let label: String
                    let quantity: Double
                    let unit: String
                }

                struct Carbs: Decodable {
                    let label: String
                    let quantity: Double
                    let unit: String
                }

                struct Protein: Decodable {
                    let label: String
                    let quantity: Double
                    let unit: String
                }
            }
        }
    }
}
