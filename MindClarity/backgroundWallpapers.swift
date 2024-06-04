//
//  backgroundWallpapers.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 24.05.24.
//

import Foundation

import SwiftUI

import Firebase

import FirebaseAuth

import FirebaseFirestore


struct multicolorWallpaper: View {
    var body: some View {
        Image("wallpaper1")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct greenWallpaper: View {
    var body: some View {
        Image("greenWallpaper")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct chosenWallpaper: View {
    @EnvironmentObject var UserSelection: userSelection
    var body: some View {
        //when the user chooses the wallpaper in setting it will portrait the chosenWallpaper from the guidelines e.g. firstWallpaper
        if UserSelection.preferredDesign == "multicolor" {
                multicolorWallpaper()
            }
        else if UserSelection.preferredDesign == "green" {
                greenWallpaper()
            }
    }
}



class userSelection: ObservableObject {
    @Published var preferredDesign: String = "green"
    
    
    //Save the preference of the user
    func savePreferencesinFirestore() {
        //Check authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: not user found")
            return
        }
        
        //Reference Firestore
        let db = Firestore.firestore()
        
        //define the array
        let designValue: [String: Any] = ["preferredDesign": preferredDesign]
        
        //
        db.collection("users").document(userID).setData(designValue)
        
    }
    
    func loadPreferencesinFirestore(){
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: not user found")
            return
        }
        
        //Reference Firestore
        let db = Firestore.firestore()
        
        //load data
        
        db.collection("users").document(userID).getDocument {
            documentSnapshot, error in
            
            if let error = error {
                print("error loading data: \(error)")
                return
            }
            else if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                if let data = documentSnapshot.data(), let preferredDesign = data["preferredDesign"] as? String {
                    self.preferredDesign = preferredDesign
                    
                    }
                }
                else {
                    print("UserDesign is nil")
                }
            }
        }
        
    }
