//
//  User.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation

struct User : Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}

