//
//  ImageView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

struct ImageView: View {
    let userId: String
    let imageModel: ImageModel
    let imageURL: URL
    let title: String?
    @FirestoreQuery var userImages: [ImageModel]
    
    init(userId: String, imageModel: ImageModel, imageURL: URL, title: String?) {
        self.userId = userId
        self.imageModel = imageModel
        self.imageURL = imageURL
        self.title = title
        self._userImages = FirestoreQuery(collectionPath: "users/\(userId)/recipes")
    }

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing){
                AsyncImage(url: imageURL) { phase in
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
                .frame(height: 200)
                .cornerRadius(10)
                Button(action: {
                    if !userImages.contains(where: { item in
                        return item.label == imageModel.label
                    }) {
                        saveRecipe()
                    } else {
                        deleteRecipe()
                    }
                }) {
                    Image(systemName: userImages.contains(where: { item in
                        return item.label == imageModel.label
                    }) == true ? "heart.fill" : "heart")
                        .padding(4)
                        .foregroundColor(userImages.contains(where: { item in
                            return item.label == imageModel.label
                        }) == true ? .red : .gray)
                .buttonStyle(PlainButtonStyle())
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))

                .background(Color.white.opacity(0.7))
                .cornerRadius(20)
                .offset(y:-10)
                }
            }
            if let title = title {
                Text(title)
                    .font(.caption)
                    .lineLimit(1)
            }
        }
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

//#Preview {
//    @State var favorite: Bool = false
//    return ImageView(userId: "", imageModel: ImageModel(imageURL: URL(string: "https://edamam-product-images.s3.amazonaws.com/web-img/2d1/2d1770d49a37ccc618c0780c2abcf2b9.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjENz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDG7zD4UUsN9P2I4o7p4c8%2FhEAdvhWAa2vB7UwAu5v%2BkgIgKxPsws53Pm2qPdLY8RRGA1bkWC7TMcAg2mVSNWZelKcquAUINBAAGgwxODcwMTcxNTA5ODYiDOJZrWcsiWkdE6jcbSqVBUk7OSAEQnbiI1CFdCZlQzscLXRGH0PEKSoHs%2FNNG2jWG2AjJfcGLUsSa1TSFlDDbEqZ6Vq%2F3mF2ioI%2BeKEKYt%2FTl5Q7m0QCCc9ITGEjAlkx%2FASRGKNAOs9L4CpxBT738mUQDFwOrc1FrjqRqHYjVwpx%2BRtEvYnDBQ9Rciw9GI4maTZCmRTSCTahNYpQF0PebwOQyvJhBTvbgquRROJqbvkYlD0pxW6vyjylfOesApfZsF40bEE4igELFtiH3e%2BJEF1YqD%2BN61Wnrcp7g0yyFMly%2B0DIxMFQ2D%2F0ze31p%2FTTtO%2FaE%2Ft8SSThLt%2FkcDQvN%2BZuJ5x%2FQG4ECjej%2FziZ43ma6R24APPublnFJOgaWEwhC09kQGTCfZhNuGYzqYwP62ZxNRQDh8T6UGk05bLQbzIqqOgSt2sWOZkxaGPCX0ik9Arnb69h7b8Stdhxld82Ouih6qvtBJeTUdSLv7N0xJbEfXaZ8UT0StFkZW7xVVUmDgawy8z7w%2BcjBcvh5MXz3ltpeV70IezDblkrvpt1McwQJwNBGmPpRGKrvqnFo6PRJ1IcPDFZubMiqKgcaKQAUwM8OAS7bU490qUT%2FHD4828bOUFl2V3uCH0%2FwfUgp6CIXlCMnF3Q2v8UrVT7Rl2IvBz1jAeOCBJDKMbScehGTtrZHSDMt3ReY5yzvqMG13Yv6dDqTACxvUHzXLWaQvJMI3LP8Xxx1tzpALQxXYMOzLo00SEQU1EKwQUnzGqSIHnTD3AeCV1z2Pr5rVCe4UpnnQYmwbPhl1OsUam7Fx8mqkQ1SuMNYEqhlDLgafZxCFYOyiLCy5CN51p0ADvUdKYHaWaiIy%2BB4f%2Fkhcag6%2F4dKqZhXtoIHrUk%2FI2qVpRe434VCdgcYxcwpKL5qgY6sQE%2B%2F%2F219QGE6KAnmfTF3QPqbmOfBiH9SBiBz92JPYWt9NniQG2%2BiyvNNeXsRZ7ctYa8CyJ0XAwlNgB2HHX7cju3Rw015z4qaZWXPabAjDkYPFeLqctF8GMpIKnkW29v19laM29CX1mLpJMtzPHdFRN66YIG%2FhwxQic0iogoWOGjAOgX3luLz4svHdkfUmhFQ2H9HMTLkrvXi2fDzlm0T7dQou%2FPu%2BbhPe%2B4ZGyiT8Gy3Ew%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20231122T192147Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFFRZOS5A2%2F20231122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=8d2df3f9b7e7b7dd3a8cdf64c6d0ca6495c1169a395b3b02cca03ac367e34cff") ?? NULL, label: "", calories: 0, shareAs: "", cuisineType: [""], mealType: [""], dietLabels: [""], healthLabels: [""], ingredients: [""], fat: 0, carbs: 0, protein: 0), imageURL: URL(string: "https://edamam-product-images.s3.amazonaws.com/web-img/2d1/2d1770d49a37ccc618c0780c2abcf2b9.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjENz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDG7zD4UUsN9P2I4o7p4c8%2FhEAdvhWAa2vB7UwAu5v%2BkgIgKxPsws53Pm2qPdLY8RRGA1bkWC7TMcAg2mVSNWZelKcquAUINBAAGgwxODcwMTcxNTA5ODYiDOJZrWcsiWkdE6jcbSqVBUk7OSAEQnbiI1CFdCZlQzscLXRGH0PEKSoHs%2FNNG2jWG2AjJfcGLUsSa1TSFlDDbEqZ6Vq%2F3mF2ioI%2BeKEKYt%2FTl5Q7m0QCCc9ITGEjAlkx%2FASRGKNAOs9L4CpxBT738mUQDFwOrc1FrjqRqHYjVwpx%2BRtEvYnDBQ9Rciw9GI4maTZCmRTSCTahNYpQF0PebwOQyvJhBTvbgquRROJqbvkYlD0pxW6vyjylfOesApfZsF40bEE4igELFtiH3e%2BJEF1YqD%2BN61Wnrcp7g0yyFMly%2B0DIxMFQ2D%2F0ze31p%2FTTtO%2FaE%2Ft8SSThLt%2FkcDQvN%2BZuJ5x%2FQG4ECjej%2FziZ43ma6R24APPublnFJOgaWEwhC09kQGTCfZhNuGYzqYwP62ZxNRQDh8T6UGk05bLQbzIqqOgSt2sWOZkxaGPCX0ik9Arnb69h7b8Stdhxld82Ouih6qvtBJeTUdSLv7N0xJbEfXaZ8UT0StFkZW7xVVUmDgawy8z7w%2BcjBcvh5MXz3ltpeV70IezDblkrvpt1McwQJwNBGmPpRGKrvqnFo6PRJ1IcPDFZubMiqKgcaKQAUwM8OAS7bU490qUT%2FHD4828bOUFl2V3uCH0%2FwfUgp6CIXlCMnF3Q2v8UrVT7Rl2IvBz1jAeOCBJDKMbScehGTtrZHSDMt3ReY5yzvqMG13Yv6dDqTACxvUHzXLWaQvJMI3LP8Xxx1tzpALQxXYMOzLo00SEQU1EKwQUnzGqSIHnTD3AeCV1z2Pr5rVCe4UpnnQYmwbPhl1OsUam7Fx8mqkQ1SuMNYEqhlDLgafZxCFYOyiLCy5CN51p0ADvUdKYHaWaiIy%2BB4f%2Fkhcag6%2F4dKqZhXtoIHrUk%2FI2qVpRe434VCdgcYxcwpKL5qgY6sQE%2B%2F%2F219QGE6KAnmfTF3QPqbmOfBiH9SBiBz92JPYWt9NniQG2%2BiyvNNeXsRZ7ctYa8CyJ0XAwlNgB2HHX7cju3Rw015z4qaZWXPabAjDkYPFeLqctF8GMpIKnkW29v19laM29CX1mLpJMtzPHdFRN66YIG%2FhwxQic0iogoWOGjAOgX3luLz4svHdkfUmhFQ2H9HMTLkrvXi2fDzlm0T7dQou%2FPu%2BbhPe%2B4ZGyiT8Gy3Ew%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20231122T192147Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFFRZOS5A2%2F20231122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=8d2df3f9b7e7b7dd3a8cdf64c6d0ca6495c1169a395b3b02cca03ac367e34cff")??, NULL, title: "")
//}

