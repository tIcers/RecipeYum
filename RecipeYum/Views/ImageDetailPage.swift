//
//  ImageDetailPage.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore

struct ImageDetailPage: View {
    let imageModel: ImageModel
    let formatter = NumberFormatter()
    var userId: String
    @FirestoreQuery var images: [ImageModel]
    
    init(imageModel: ImageModel, userId: String) {
        self.imageModel = imageModel
        self._images = FirestoreQuery(collectionPath: "users/\(userId)/recipes")
        self.userId = userId
    }
    
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
                
                if !images.contains(where: { item in
                    return item.label == imageModel.label
                }) {
                    Button(action: {
                        saveRecipe()
                    }) {
                        Text("Save Dish")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                } else {
                    Button(action: {
                        deleteRecipe()
                    }) {
                        Text("Delete Dish")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                }
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
    
    func saveRecipe() {
        let newId = imageModel.id.uuidString
        
        // Save the model
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("recipes")
            .document(newId)
            .setData(imageModel.asDictionary())
    }
    
    func deleteRecipe() {
        // Save the model
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("recipes")
            .document(imageModel.id.uuidString)
            .delete()
    }
}


