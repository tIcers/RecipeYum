//
//  ContentView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-02.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            NavView()
        } else {
            Text("Hello")
        }
    }
}

#Preview {
    ContentView()
}
