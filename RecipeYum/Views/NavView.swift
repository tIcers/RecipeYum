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
            }
            ListView().tabItem {
                Image(systemName: "frying.pan.fill")
                Text("My Recipes")
            }
            AccountView().tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Account")
            }
        }
    }
}

#Preview {
    NavView()
}
