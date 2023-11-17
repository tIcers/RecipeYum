//
//  ImageModel.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import Foundation
import Combine

struct ImageModel: Codable, Identifiable {
    let id: UUID
    let imageURL: URL
    let label: String
    let calories: Double
    let cuisineType: [String]
    let mealType: [String]
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredients: [String]
    let fat: Double
    let carbs: Double
    let protein: Double
    
    init(
        id: UUID = UUID(),
        imageURL: URL,
        label: String,
        calories: Double,
        cuisineType: [String],
        mealType: [String],
        dietLabels: [String],
        healthLabels: [String],
        ingredients: [String],
        fat: Double,
        carbs: Double,
        protein: Double
    ) {
        self.id = id
        self.imageURL = imageURL
        self.label = label
        self.calories = calories
        self.cuisineType = cuisineType
        self.mealType = mealType
        self.dietLabels = dietLabels
        self.healthLabels = healthLabels
        self.ingredients = ingredients
        self.fat = fat
        self.carbs = carbs
        self.protein = protein
    }
}

