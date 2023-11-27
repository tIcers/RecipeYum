//
//  RegisterView.swift
//  RecipeYum
//
//  Created by Neil CAO on 2023-10-16.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(#colorLiteral(red: 0.02745098039, green: 0.4235294118, blue: 0.6823529412, alpha: 1)))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .offset(CGSize(width: 0.0, height: 50.0))
                .background(
                            Image("register")
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                        )

            Form {
                if !viewModel.errMsg.isEmpty {
                    Text(viewModel.errMsg)
                        .foregroundColor(.red)
                }
                
                Section() {
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Full Name", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                            .padding(.vertical)
                        

                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .padding(.bottom)

                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                            .listRowSeparator(.hidden)
                    }
                    
                    
                        Button() {
                            viewModel.register()
                        } label: {
                            Text("Create Account")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .controlSize(.large)
                        .background(Color(.accent))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .listRowSeparator(.hidden)
                    
                    
                }
            }
            .padding(.top, -10.0) // Remove padding
        }
    }
}

#Preview {
    RegisterView()
}
