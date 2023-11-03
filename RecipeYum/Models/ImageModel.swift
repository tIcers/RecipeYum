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
    let foodName:String
    
    init(id:UUID = UUID(), imageURL:URL, foodName:String){
        self.id = id
        self.imageURL = imageURL
        self.foodName = foodName
    }
}
