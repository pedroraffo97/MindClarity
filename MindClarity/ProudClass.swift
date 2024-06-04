//
//  ProudClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 24.02.24.
//

import Foundation


import SwiftUI

import FirebaseFirestore

import FirebaseAuth

import Firebase


struct proudPoint: Hashable, Encodable, Decodable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
}

//fileManager
func getFileManagerProuddata() -> URL{
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("Prouddata.json")
}

class proudClass: ObservableObject {
    @Published var savedProudPoints: [proudPoint] = []
    
    // functions to save and load data from Firestore
    
    func addProudDatatoFirestore(prouddata: proudPoint) {
        
        // check Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error setting data: User not Authenticated")
            return
        }
        
        //create reference to Firestore
        let db = Firestore.firestore()
        
        //set values and keys
        let proudValues: [String: Any] = [
            "id": prouddata.id.uuidString,
            "name" : prouddata.name,
            "description": prouddata.description
        ]
        
        //add the values in Firestore
        
        db.collection("users").document(userID).collection("proudData").document(prouddata.id.uuidString).setData(proudValues, merge: true)
    }
    
    //function to get data from Firestore
    func loadProudDatafromFirestore() {
        //check Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error getting data: User not Authenticated")
            return
        }
        
        //reference to Firestore
        let db = Firestore.firestore()
        
        //load data from Firestore
        db.collection("users").document(userID).collection("proudData").getDocuments {
            snapshot, error in
            //check errors
            if let error = error {
                print("Error found loading data: \(error)")
            }
            else {
                //check if snapshot is nil
                if let snapshot = snapshot {
                    //Retrieve the documents from Firestore
                    self.savedProudPoints = snapshot.documents.compactMap {
                        document in
                        
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let name = data["name"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        
                        return proudPoint(id: id, name: name, description: description)}
                }
                else {
                    print("Snapshot is nil")
                }
            }
        }
    }
    
    //function to delete Data from Firestore
    func deleteDatafromFirestore(proudData: proudPoint) {
        //check Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error deleting: User not Authenticated")
            return
        }
        
        //reference to Firestore
        let db = Firestore.firestore()
        
        //delete the selected collection
        
        db.collection("users").document(userID).collection("proudData").document(proudData.id.uuidString).delete()
        
        
    }
    
    
}
