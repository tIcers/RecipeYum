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
            VStack(spacing: 10) {
                AsyncImage(url: imageModel.imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure, .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        Text("Unknown Image Phase")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(10)
                
                
                Text("\(imageModel.label)")
                    .font(.title)
                    .padding(.vertical, 10)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Nutrients:")
                        .font(.headline) // Make the text bold
                        .multilineTextAlignment(.center) // Center-align the text
                        .padding(.bottom, 20) // Add padding between "Ingredients" and the ingredient list
                    
                    let columns: [GridItem] = [
                        GridItem(.fixed(150)),
                        GridItem(.fixed(150))
                    ]
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                        Text("Calories: \(formattedNumber(imageModel.calories)) kcal")
                        Text("Protein: \(formattedNumber(imageModel.protein)) g")
                        Text("Fat: \(formattedNumber(imageModel.fat)) g")
                        Text("Carbs: \(formattedNumber(imageModel.carbs)) g")
                    }
                    .padding(.bottom, 20)
                    // Use joined(separator:) to add line breaks between ingredients
                    Text("Ingredients:")
                        .font(.headline) // Make the text bold
                        .multilineTextAlignment(.center) // Center-align the text
                        .padding(.bottom, 20) // Add padding between "Ingredients" and the ingredient list
                    
                    Text(imageModel.ingredients.map { "- \($0)" }.joined(separator: "\n"))
                        .fixedSize(horizontal: false, vertical: true) // Allow multiline text to wrap
                        .padding(.bottom, 10) // Add padding between each line of ingredients
                    
                    if let shareAsURL = URL(string: imageModel.shareAs) {
                        Link("Link: \(imageModel.label)", destination: shareAsURL)
                            .padding(.bottom, 8)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
                
                if !images.contains(where: { item in
                    return item.label == imageModel.label
                }) {
                    Button {
                        saveRecipe()
                    } label: {
                        Text("Save Dish")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .controlSize(.large)
                    .background(Color(#colorLiteral(red: 0.4666666667, green: 0.768627451, blue: 0.8705882353, alpha: 1)))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .listRowSeparator(.hidden)
                    .padding(.bottom, 20)
                } else {
                    Button {
                        deleteRecipe()
                    } label: {
                        Text("Delete Dish")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .controlSize(.large)
                    .background(Color(red: 249/255, green: 124/255, blue:124/255))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .listRowSeparator(.hidden)
                    .padding(.bottom, 20)
                }
            }
        }
        .padding(.horizontal, 50.0)
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


#Preview {
    let imageModel = ImageModel(id: UUID(), imageURL: URL(string: "https://example.com/image.jpg")!, label: "Chicken breast", calories: 200, shareAs: "https://example.com/share", cuisineType: ["Italian", "Chinese"], mealType: ["Breakfast", "Dinner"], dietLabels: ["Low-Carbs", "Low-Fat"], healthLabels: ["Healthy", "Keto"], ingredients: ["Chicken", "Salt"], fat: 30, carbs: 100, protein: 100)
        return ImageDetailPage(imageModel: imageModel, userId: "TestUser")
}
