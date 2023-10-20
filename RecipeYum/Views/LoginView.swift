//
//  LoginView.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                // Header
                HeaderView(title: "Login", subtitle: "RecipeYum", login_image: Image("login_img"))
                
                // Login Form
                
                Form {
                    if !viewModel.errMsg.isEmpty {
                        Text(viewModel.errMsg)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Log in")
                    {
                        viewModel.login()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
                
                // Link to create an account
                VStack {
                    Text("New User?")
                    NavigationLink("Create an account") {
                        RegisterView()
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
