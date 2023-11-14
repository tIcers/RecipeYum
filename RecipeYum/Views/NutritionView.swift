//
//  NutritionView.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-11-12.
//

import SwiftUI

struct NutritionView: View {
    var body: some View {
        // Customize this section with your nutrition information
        VStack(alignment: .leading, spacing: 8) {
            Text("Calories: ")
            Text("Protein: ")
            Text("Fat: ")
            Text("Carbs: ")
            Text("Ingredients: ")
            Text("Details: ")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    NutritionView()
}
