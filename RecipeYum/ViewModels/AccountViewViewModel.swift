//
//  AccountViewViewModel.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AccountViewViewModel: ObservableObject {
    @Published var user: User = User(id: "", name: "", email: "", joined: TimeInterval())
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument {[weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    func update(completion: @escaping (Bool, String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, "User ID not available")
            return
        }

        let db = Firestore.firestore()

        db.collection("users").document(userId).updateData([
            "name": user.name,
            "email": user.email
        ]) { error in
            if let error = error {
                print("Error updating user data: \(error)")
                completion(false, error.localizedDescription)
            } else {
                print("User data successfully updated")
                completion(true, "")
            }
        }
    }

    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print (error)
        }
    }
}
