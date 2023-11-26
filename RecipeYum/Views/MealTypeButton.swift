//
//  MealTypeButton.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-11-25.
//

import SwiftUI

struct MealTypeButton: View {
    let title: String
    let emoji: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(emoji)
                    .font(.largeTitle)
                    .frame(width: 44, height: 44) // Set a fixed size for the emoji
                Text(title)
                    .font(.caption2)
            }
            .padding(6.0)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(7)
            .shadow(
                color: Color.black.opacity(0.3),
                radius: 3,
                x: 2,
                y: 2
            )
        }
    }
}

#Preview {
    MealTypeButton(title: "Breakfast", emoji: "🍳") {
        print("Breakfast button tapped")
    }
    .previewLayout(.sizeThatFits)
    .padding()
}

