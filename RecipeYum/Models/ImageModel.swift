//
//  ImageModel.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import Foundation
import Combine

struct ImageModel : Identifiable{
    let id:UUID
    let imageURL:URL
    
    init(id:UUID = UUID(), imageURL:URL){
        self.id = id
        self.imageURL = imageURL
    }
}
