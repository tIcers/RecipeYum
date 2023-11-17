//
//  ContentViewViewModel.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-13.
//

import Foundation
import FirebaseAuth

class ContentViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
        print("hello")
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
