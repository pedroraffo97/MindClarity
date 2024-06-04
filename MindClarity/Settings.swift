//
//  Settings.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 16.05.24.
//

import Foundation

import SwiftUI

import Firebase

import FirebaseAuth

struct AppSettings: View {
    
    @State var userEmail: String = ""
    @EnvironmentObject var userData: UserLibrary
    
    
    func fetchUserEmail() {
        //check first if the user is signed in
        if let user = Auth.auth().currentUser {
            //access to user email
            if let FirebaseEmail = user.email {
                userEmail = FirebaseEmail
            } else {
                userEmail = "no eMail found"
            }
        } else {
            userEmail = "no user is signed in"
        }
    }
    
    var body: some View {
        ScrollView {
                //acccount section
                VStack(alignment: .leading){
                    Text("Account")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .bold()
                        .padding()
                }
                //email and password of your current firestore
                VStack (alignment: .center) {
                    VStack {
                        Text("Email")
                            .font(.headline)
                            .bold()
                            .padding()
                        Text("\(userEmail)")
                    }
                    .padding(20.0)
                    ForEach(userData.userDataBase){ index in
                        VStack {
                            Text("Name")
                                .font(.headline)
                                .bold()
                                .padding()
                            Text("\(index.name)")
                        }
                        .padding()
                    }
                    NavigationLink {
                        UserViewEdit()
                    } label: {
                        Label("Edit Profile", systemImage: "person")
                        Image(systemName: "arrow.right.circle")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                
                //display section
                VStack(alignment:.leading){
                    Text("Display")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .bold()
                        .padding()
                }
                VStack(alignment:.center) {
                    NavigationLink {
                        designMenu()
                    } label: {
                        Label("Background", systemImage: "paintbrush")
                        Image(systemName: "arrow.right.circle")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
                
                
                //userlogOut section
                VStack(alignment: .center) {
                    UserLogOut()
                }
                .padding(75.0)
            
            }
        .frame(maxWidth: .infinity)
        .background(chosenWallpaper())
        .navigationTitle("Settings")
        .onAppear {
                fetchUserEmail()
            }
        }
    }

#Preview {
    AppSettings(userEmail: "pedroraffo97@gmail.com")
        .environmentObject(UserLibrary())
}
