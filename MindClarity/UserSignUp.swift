//
//  UserSignUp.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 27.03.24.
//

import Foundation

import SwiftUI


struct UserSignUp: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var signUpError: Error?
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack{
                chosenWallpaper()
                VStack {
                    //Sign Up Form
                    TextField("create a new Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("create a new Password",text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // to return the function to see if it is authenticated
                    Button {
                        signUp()
                        dismiss()
                    } label: {
                        Label("Sign Up",systemImage: "person.fill.badge.plus")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    //shows an error if the SignUp could not load because of an error.
                    if let error = signUpError {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                }
                .navigationTitle("Sign Up")
                
            }
            .onAppear{
                AuthManager().isAuthenticated = false
            }
        }
    }

    
    func signUp(){
        AuthManager.shared.SignUp(email: email, password: password)
        }
    }
