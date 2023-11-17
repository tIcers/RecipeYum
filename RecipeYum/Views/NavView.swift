//
//  NavView.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-13.
//

import SwiftUI

struct NavView: View {
    @State var userId: String
    var body: some View {
        TabView {
            HomeView(userId: userId).tabItem {
                Image(systemName: "house.circle.fill")
                Text("Home")
            }.tag(1)
            ListView(userId: userId).tabItem {
                Image(systemName: "frying.pan.fill")
                Text("My Recipes")
            }.tag(1)
            AccountView(userId: userId).tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Account")
            }.tag(3)
        }
    }
}

#Preview {
    NavView(userId: "sample")
}
