//
//  ImageDetailPage.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import SwiftUI

struct ImageDetailPage: View {
    let imageModel: ImageModel
    let formatter = NumberFormatter()
    
    
    var body: some View {
        ScrollView {
            VStack {
                ImageView(imageURL: imageModel.imageURL, title: nil, isFavorite: .constant(false))
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text("\(imageModel.label)")
                    .font(.title)
                    .padding(.top, 10)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Nutrients:")
                        .font(.headline) // Make the text bold
                        .multilineTextAlignment(.center) // Center-align the text
                        .padding(.bottom, 8) // Add padding between "Ingredients" and the ingredient list
                    
                    Text("Calories: \(formattedNumber(imageModel.calories)) kcal")
                    Text("Protein: \(formattedNumber(imageModel.protein)) g")
                    Text("Fat: \(formattedNumber(imageModel.fat)) g")
                    Text("Carbs: \(formattedNumber(imageModel.carbs)) g \n")
                    // Use joined(separator:) to add line breaks between ingredients
                    Text("Ingredients:")
                        .font(.headline) // Make the text bold
                        .multilineTextAlignment(.center) // Center-align the text
                        .padding(.bottom, 8) // Add padding between "Ingredients" and the ingredient list
                    
                    Text(imageModel.ingredients.joined(separator: "\n"))
                        .fixedSize(horizontal: false, vertical: true) // Allow multiline text to wrap
                        .padding(.bottom, 8) // Add padding between each line of ingredients
                    
                    // Add other details as needed
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
                
                Button(action: {
                    // Add your save dish functionality here
                }) {
                    Text("Save Dish")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Recipe Detail")
            .padding()
        }
    }
    
    func formattedNumber(_ value: Double) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0

            return "\(formatter.string(from: NSNumber(value: value)) ?? "")"
        }
}


