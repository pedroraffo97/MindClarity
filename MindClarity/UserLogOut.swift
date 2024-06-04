//
//  UserLogOut.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 29.03.24.
//

import Foundation


import SwiftUI

import FirebaseAuth

import Firebase


struct UserLogOut: View {
    @Environment(\.dismiss) var dismiss
    
    func LogOut() {
        AuthManager.shared.signOut()
        AuthManager().isAuthenticated = false
        clearLocalData()
        let userID = Auth.auth().currentUser?.uid
        print("User succesfully signed out")
        //check if there was a user id stranded after signing out
        print("the current user id is \(userID ?? "No User")")
    }
    var body: some View {
                    Button {
                        LogOut()
                        dismiss()
                    } label: {
                            Label("Log Out", systemImage: "person.badge.key.fill")
                        }
                        .font(.headline)
                        .buttonStyle(.bordered)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    UserLogOut()
}
