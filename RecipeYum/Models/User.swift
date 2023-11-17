//
//  User.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation

struct User : Codable, Identifiable {
    var id: String
    var name: String
    var email: String
    var joined: TimeInterval
}

