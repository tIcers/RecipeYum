//
//  ListViewViewModel.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-11-17.
//

import Foundation
import FirebaseFirestoreSwift

class ListViewViewModel: ObservableObject {
    let userId: String    
    
    init(userId: String) {
        self.userId = userId
        
    }
}
