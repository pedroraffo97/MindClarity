//  UserSignIn.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 27.03.24.
//

import Foundation

import SwiftUI


struct UserSignIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signInError: Error?
    
    
    var body: some View {
        VStack {
            ZStack {
                chosenWallpaper()
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button {
                    signIn()
                } label: {
                    Label("Sign In", systemImage: "person.crop.circle.fill.badge.checkmark")
                }
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                
                VStack{
                    Text("Not yet in MindClarity?")
                        .padding()
                    NavigationLink {
                        UserSignUp()
                    } label: {
                        Label("Create a new account!",systemImage: "person.fill.badge.plus")
                    }
                }
                
                //shows an error if the signIn could not load because of an error.
                if let error = signInError {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
                
            }
            .navigationTitle("Sign In")
            
        }
        .onAppear {
            AuthManager().isAuthenticated = false
        }
    }
}
    
    func signIn(){
        AuthManager.shared.signIn(email: email, password: password)
    }
}
