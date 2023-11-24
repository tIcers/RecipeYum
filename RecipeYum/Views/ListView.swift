//
//  ListView.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-06.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ListView: View {
    @State var userId: String
    @FirestoreQuery var images: [ImageModel]

    init(userId: String) {
        self.userId = userId
        self._images = FirestoreQuery(collectionPath: "users/\(userId)/recipes")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    ForEach(images) { image in
                        let _ = print(image.imageURL)
                        NavigationLink(destination: ImageDetailPage(imageModel: image, userId: userId)) {
                            ImageView(userId: userId, imageModel: image, imageURL: image.imageURL, title: image.label)
                                .cornerRadius(10)
                                .padding(8)
                        }
                    }
                }
            }
            .navigationTitle("My Recipes")
        }
    }
}

#Preview {
    ListView(userId: "sample")
}
