//
//  UserClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.03.24.
//

import Foundation


import SwiftUI

import Firebase

import FirebaseAuth

import FirebaseFirestore

struct User: Identifiable, Equatable, Encodable, Decodable {
    var name: String
    var age: String
    var photo: String = "imagebackground"
    var description: String
    var id = UUID()
}

//filemanager
func getFileManagerUserData() -> URL{
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("userdata.json")
}

class UserLibrary: ObservableObject {
    @Published var userDataBase: [User] = []
    
    
    func addUserDatainFirestore(user: User) {
        //authenticate with the user ID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User is not authenticated")
            return
        }
        
        //reference to the database:
        let db = Firestore.firestore()
        
        let userValues: [String: Any] = [
            
            "id": user.id.uuidString,
            "name": user.name,
            "age": user.age,
            "photo": user.photo,
            "description": user.description
        ]
        
        db.collection("users").document(userID).collection("userData").document(user.id.uuidString).setData(userValues, merge: true) {error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("UserData Document successfully written!")
            }
        }
    }
    
    func loadUserDatainFirestore(){
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User is not authenticated")
            return
        }
        
        //reference to the database
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).collection("userData").getDocuments{
            snapshot, error in
            //Check for errors
            if let error = error {
                print("Error getting UserData documents: \(error)")
            } else {
                //no error
                //check if snapshot is nil
                if let snapshot = snapshot {
                    //Retrieve documents from Firestore
                    
                    self.userDataBase = snapshot.documents.compactMap {
                        document in
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let name = data["name"] as? String ?? ""
                        let age = data["age"] as? String ?? ""
                        let description = data["photo"] as? String ?? ""
                        
                        return User(name: name, age: age, description: description, id: id)
                    }
                }
                else {
                    print("UserData Snapshot is nil")
                }
            }
        }
    }
    
    func deleteUserDatafromFirestore(user: User) {
        //authenticate with userID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error, User is not authenticated")
            return
        }
        
        //reference to the database
        let db = Firestore.firestore()
        
        let userValues: [String: Any] = [
            "id" : user.id.uuidString,
            "name" : user.name,
            "age": user.age,
            "photo": user.photo
        ]
        
        //Specify the document to delete
        db.collection("users").document(userID).collection("userData").document(user.id.uuidString).delete()
    }
    
    
}
