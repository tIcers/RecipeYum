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
                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .offset(CGSize(width: 0.0, height: -60.0))
                    .background(
                        Image("login")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    )
                // Login Form
                
                Form {
                    if !viewModel.errMsg.isEmpty {
                        Text(viewModel.errMsg)
                            .foregroundColor(.red)
                    }
                    
                    Section() {
                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .padding(.vertical)
                            .listRowSeparator(.hidden)

                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                            .listRowSeparator(.hidden)
                        
                        Button()
                        {
                            viewModel.login()
                        } label: {
                            Text("Log In")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .controlSize(.large)
                        .background(Color(.accent))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    }
                    
                }
                .padding(.top, -10.0) // Remove padding
                
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
