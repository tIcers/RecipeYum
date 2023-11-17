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
    @State var isTrue = true
    @FirestoreQuery var images: [ImageModel]

    init(userId: String, isTrue: Bool = true) {
        self.userId = userId
        self.isTrue = isTrue
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
                            ImageView(imageURL: image.imageURL, title: image.label, isFavorite: $isTrue)
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
