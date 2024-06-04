//
//  AuthenticationManager.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 27.03.24.
//

import Foundation

import SwiftUI

import Firebase

import FirebaseAuth

import FirebaseFirestore

class AuthManager: ObservableObject {
    //Singleton design pattern: defining a static shared property: ensuring there is only one instance of AuthManager in the app.
    static let shared = AuthManager()
    
    //Declares a published property to track the authentication status of the user in the whole app.
    @Published var isAuthenticated = false
    
    //Declares a published property that will change depending on the sign in of the user.
    @Published var userID: String?
    
    
    init() {
        updateUserID() // Call updateUserID when AuthManager is initialized
    }
    
    //local function to update the userID with the currentUser, once the currentUser is set.
    private func updateUserID() {
        if let currentUser = Auth.auth().currentUser {
            userID = currentUser.uid
            
        } else {
            userID = nil
        }
    }
    
        
    // method to sign in an already created account in Fireplace
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] authResult, error in
            guard error == nil,
            let _ = authResult else {
                print("Error signing in: \(error?.localizedDescription ?? "")")
                self?.isAuthenticated = false
                return
                }
            // Update isAuthenticated directly upon succesful sign-in
            print("Succesfully Sign in")
            self?.isAuthenticated = true
            
            }
        }
    
    //method to checks if there is an authenticated current user.
    func isUserAuthenticated() -> Bool {
            // Check if there is a currently authenticated user
            if let _ = Auth.auth().currentUser {
                // User is authenticated
                print("the current user is \(userID ?? "nil")")
                return true
            } else {
                // No user is authenticated
                return false
            }
        }
    
    //method to create a new user in Fireplace
    func SignUp(email: String, password: String) {
            Auth.auth().createUser(withEmail: email, password: password) {
                [weak self] authResult, error in
                guard error == nil,
                let _ = authResult else {
                    self?.isAuthenticated = false
                    return
                }
                print("Succesfully Sign Up")
                self?.isAuthenticated = true
            }
        }

    //method for the user to sign out from the app.
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            print("Succesfully sign Out")
        }
        catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
