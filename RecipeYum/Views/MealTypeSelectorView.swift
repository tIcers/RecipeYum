//
//  MealTypeSelectorView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-11-25.
//

import SwiftUI

struct MealTypeSelector: View {
    let mealTypes: [String: String]
    @Binding var selectedMealType: String
    var onSelect: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(mealTypes.sorted(by: <), id: \.key) { key, emoji in
                    MealTypeButton(title: key, emoji: emoji) {
                        selectedMealType = key
                        onSelect(key)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let mealTypes = ["Breakfast": "🍳", "Lunch": "🥪", "Dinner": "🍲"]
    @State var selectedMealType: String = "Breakfast"
    return MealTypeSelector(mealTypes: mealTypes, selectedMealType: $selectedMealType) {_ in
        print("Breakfast button tapped")
    }
}
