//
//  ImageDetailPage.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import SwiftUI

struct ImageDetailPage: View {
    let imageURL: URL

    var body: some View {
        ImageView(imageURL: imageURL)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Image Detail")
    }
}

