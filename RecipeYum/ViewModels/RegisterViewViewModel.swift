//
//  RegisterViewViewModel.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var errMsg: String = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        // register user with Firebase Auth
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
           guard let userId = result?.user.uid else {
              return
           }
           self?.insertUser(id: userId)
        }

        
    }
    
    // we are not creating a auth user here
    // we are adding custom data to firestore
    func insertUser(id: String) {
        let usr = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(usr.asDictionary())
    }
    
    private func validate() -> Bool {
        errMsg = ""
        
        // check that input not empty
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errMsg = "Please fill in name, email and password fields."
            return false
        }
        
        // email@foo.com
        guard email.contains("@") && email.contains(".") else {
            errMsg = "Please enter a valid email address."
            return false
        }
        
        guard password.count >= 6 else {
            errMsg = "Password must be at least 6 characters long."
            return false
        }
        
        return true
    }
    
}

