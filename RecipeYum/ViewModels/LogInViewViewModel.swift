//
//  LogInViewViewModel.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errMsg: String = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        errMsg = ""
        
        // check that input not empty
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errMsg = "Please fill in email and password fields."
            return false
        }
        
        // email@foo.com
        guard email.contains("@") && email.contains(".") else {
            errMsg = "Please enter a valid email address."
            return false
        }
        
        return true
    }
}
