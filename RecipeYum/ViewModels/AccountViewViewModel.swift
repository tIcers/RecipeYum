//
//  AccountViewViewModel.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation

class AccountViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var errMsg: String = ""
    
    init() {}
}
