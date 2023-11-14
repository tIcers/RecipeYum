//
//  Recipe.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-11-12.
//


// *****************for reference only*****************
import Foundation

struct RecipeJsonField: Codable {
    let hits: [Hit]?
}

struct Hit: Codable {
    let recipe: Recipe?
}


struct Recipe: Codable {
    // recipe name
    let label: String?
    // image url
    let image: String?
    // edamam recipe site
    let shareAs: String?
    // i.e. "low-carb"
    let dietLabels: [String]?
    // i.e. "Diary-free"
    let healthLabels: [String]?
    // an array of ingredients
    let ingredientLines: [String]?
    let calories: Double?
    // a string array of cuisine type
    let cuisineType: [String]?
    // i.e. lunch/dinner
    let mealType: [String]?
    let totalNutrients: [Nutrient]?
}

struct Nutrient: Codable {
    let FAT: [Fat]?
    let CHOCDF: [Carbs]?
    let PROCNT: [Protein]?
}

struct Fat: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}

struct Carbs: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}

struct Protein: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}

extension URLSession {
  func fetchData(at url: URL, completion: @escaping (Result<[RecipeJsonField], Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let toDos = try JSONDecoder().decode([RecipeJsonField].self, from: data)
          completion(.success(toDos))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
