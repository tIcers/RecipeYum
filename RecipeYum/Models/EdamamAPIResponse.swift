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
            let image: String
            let label: String
        }
    }
}
