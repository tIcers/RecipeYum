//
//  RegisterView.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        // Header
        VStack {
            Spacer()
        }
        HeaderView(title: "Register", subtitle: "munch munch...", login_image: Image("register_img"))
        
        // Register Form
        Form {
            if !viewModel.errMsg.isEmpty {
                Text(viewModel.errMsg)
                    .foregroundColor(.red)
            }
            
            TextField("Full name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled()

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            Button("Create Account")
            {
                viewModel.register()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .offset(y: -50)
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()

    }
}

#Preview {
    RegisterView()
}
