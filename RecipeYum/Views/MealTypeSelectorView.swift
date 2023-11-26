//
//  MealTypeSelectorView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-11-25.
//

import SwiftUI

struct MealTypeSelector: View {
    let mealTypes: [(String, String)]
    @Binding var selectedMealType: String
    var onSelect: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(mealTypes, id: \.0) { mealType, emoji in
                    MealTypeButton(title: mealType, emoji: emoji) {
                        selectedMealType = mealType
                        onSelect(mealType)
                    }
                }
            }
            .padding([.leading, .bottom])
        }
    }
}

#Preview {
    let mealTypes = [("Breakfast", "🍳"), ("Lunch", "🥪"), ("Dinner", "🍲")]
    @State var selectedMealType: String = "Breakfast"
    return MealTypeSelector(mealTypes: mealTypes, selectedMealType: $selectedMealType) {_ in
        print("Breakfast button tapped")
    }
}
