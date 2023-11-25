//
//  MealTypeButton.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-11-25.
//

import SwiftUI

struct MealTypeButton: View {
    let title: String
    let emoji : String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(emoji)
                    .font(.largeTitle)
                Text(title)
                    .font(.caption)
            }
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}
