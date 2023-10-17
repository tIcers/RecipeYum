//
//  NavView.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-13.
//

import SwiftUI

struct NavView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house.circle.fill")
                Text("Home")
            }.tag(1)
            ListView().tabItem {
                Image(systemName: "frying.pan.fill")
                Text("My Recipes")
            }.tag(1)
            AccountView().tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Account")
            }.tag(3)
        }
    }
}

#Preview {
    NavView()
}
