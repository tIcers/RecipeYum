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
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
                
                Section(header: Text("Register Information")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Full Name:")
                        TextField("Your full name", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                        
                        Text("Email:")
                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()

                        Text("Password:")
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Section {
                        Button() {
                            viewModel.register()
                        } label: {
                            Text("Create Account")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .controlSize(.large)
                        .background(Color(#colorLiteral(red: 0.4666666667, green: 0.768627451, blue: 0.8705882353, alpha: 1)))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
