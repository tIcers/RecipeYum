//
//  AccountViewViewModel.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AccountViewViewModel: ObservableObject {
    @Published var user: User = User(id: "", name: "", email: "", joined: TimeInterval())
    @Published var selectedImage: UIImage? // Add this line
    
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

                // Check if there's a profile picture URL in the data
                
                    // Use the profile picture URL to load the image directly from Firebase Storage
                    let storage = Storage.storage()
                    let storageRef = storage.reference()
                    let profilePicRef = storageRef.child("profile_pictures/\(userId).jpg")

                    // Introduce a flag to track whether the image has been attempted to be loaded
                    var hasLoadedImage = false

                    // Fetch the image only if it hasn't been loaded yet
                    if !hasLoadedImage {
                        profilePicRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            // Update the flag regardless of whether the download was successful or not
                            hasLoadedImage = true

                            if let error = error {
                                print("Error downloading profile picture: \(error)")

                                // Set selectedImage to nil or any default image if the image doesn't exist
                                self?.selectedImage = nil
                                hasLoadedImage = false
                                return
                            } else if let data = data, let uiImage = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.selectedImage = uiImage
                                }
                            }
                        }
                    }
                
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
    
    func uploadProfilePicture(imageData: Data, completion: @escaping (Bool, String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, "User ID not available")
            return
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()

        let profilePicRef = storageRef.child("profile_pictures/\(userId).jpg")

        profilePicRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                completion(false, error?.localizedDescription ?? "Unknown error")
                return
            }

            // You can also access the download URL after upload if needed
            profilePicRef.downloadURL { (url, error) in
                guard let _ = url else {
                    completion(false, error?.localizedDescription ?? "Unknown error")
                    return
                }

                // Update your user data in Firestore to store the profile picture URL
                // For example:
                // db.collection("users").document(userId).updateData([
                //     "profilePictureURL": url!.absoluteString
                // ]) { error in
                //     // Handle the update completion
                // }

                completion(true, "Profile picture uploaded successfully")
            }
        }
    }
}
