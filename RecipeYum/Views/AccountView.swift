//
//  AccountView.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-06.
//

import SwiftUI
import FirebaseFirestoreSwift

struct AccountView: View {
    @StateObject var viewModel = AccountViewViewModel()
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    
    init(userId: String) {
    }
    
    var body: some View {
        // Header
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
//            HeaderView(title: "Account", subtitle: "update info", login_image: Image("update_img"))
            
            Section(header: Text("\(viewModel.user.name)")
                .font(.title2)
                .fontWeight(.semibold)) {
                VStack {
                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                    }

                    Button("Select Profile Picture") {
                        isImagePickerPresented.toggle()
                    }
                    .fileImporter(isPresented: $isImagePickerPresented, allowedContentTypes: [.image]) { result in
                        do {
                            let file = try result.get()
                            if let imageData = try? Data(contentsOf: file) {
                                selectedImage = UIImage(data: imageData)
                                viewModel.uploadProfilePicture(imageData: imageData) { success, message in
                                    if success {
                                        // Handle success
                                    } else {
                                        showAlert = true
                                        alertMessage = "Error uploading profile picture: \(message)"
                                    }
                                }
                            }
                        } catch {
                            // Handle the error
                            showAlert = true
                            alertMessage = "Error selecting profile picture: \(error.localizedDescription)"
                        }
                    }
                    .onAppear {
                        // Fetch user data including profile picture URL
                        viewModel.fetchUser()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Update Status"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    
                }
                
            }
            
            // Register Form
            Form {
                let _ = setUser()
                
                Section(header: Text("Profile Information")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Full Name:")
                        TextField("\(viewModel.user.name)", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                        
                        Text("Email:")
                        TextField("\(viewModel.user.email)", text: $userEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                    
                    Section {
                        HStack {
                            Button("Update") {
                                if userName.isEmpty || userEmail.isEmpty {
                                    showAlert = true
                                    alertMessage = "Both name and email are required."
                                } else {
                                    viewModel.user.name = userName
                                    viewModel.user.email = userEmail
                                    viewModel.update { success, message in
                                        if success {
                                            showAlert = true
                                            alertMessage = "User data successfully updated"
                                        } else {
                                            showAlert = true
                                            alertMessage = "Error updating user data: \(message)"
                                        }
                                        // Reset showAlert to false after presenting the alert
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            showAlert = false
                                        }
                                    }
                                }
                            }
                            .buttonStyle(BorderedButtonStyle())
                            .controlSize(.large)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button("Logout") {
                                viewModel.logout()
                            }
                            .buttonStyle(BorderedButtonStyle())
                            .controlSize(.large)
                            .background(Color.red)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Update Status"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .background(Color(.systemBackground))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func setUser() {
        viewModel.fetchUser()
    }
}

#Preview {
    AccountView(userId: "sample")
}
