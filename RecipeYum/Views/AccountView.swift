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
    
    
    init(userId: String) {
    }
    
    var body: some View {
        // Header
        VStack {
            Spacer()
            HeaderView(title: "Account", subtitle: "update info", login_image: Image("update_img"))
            
            // Register Form
                Form {
//                    if !viewModel.errMsg.isEmpty {
//                        Text(viewModel.errMsg)
//                            .foregroundColor(.red)
//                    }
                    let _ = setUser()
                    
                    Text("Full Name:")
                    TextField("Full name", text: $viewModel.user.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()

                    Text("Email: ")
                    TextField("Email", text: $viewModel.user.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                    
                    
                    Button("Update") {
                        viewModel.logout()
                    }
                    .buttonStyle(BorderedButtonStyle()) // Use BorderedButtonStyle
                    .controlSize(.large)
                    .background(Color.blue) // Change the background color here
                    .cornerRadius(8)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    
                    Button("Logout") {
                        viewModel.logout()
                    }
                    .buttonStyle(BorderedButtonStyle()) // Use BorderedButtonStyle
                    .controlSize(.large)
                    .background(Color.red) // Change the background color here
                    .cornerRadius(8)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                }

        }
    }
    
    func setUser() {
        viewModel.fetchUser()
    }
}

#Preview {
    AccountView(userId: "sample")
}
