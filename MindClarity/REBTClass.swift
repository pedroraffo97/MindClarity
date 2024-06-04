//
//  REBTClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 08.01.24.
//

import Foundation

import SwiftUI

import FirebaseFirestore

import Firebase

import FirebaseAuth


//create a single Identifiable struct that we are going to use to save each one of the REBT Sessions

struct Session: Identifiable, Encodable, Decodable, Hashable {
    var activatingEvent: String
    var belief: String
    var disputation: String
    var consequences: String
    var effective: String
    var id = UUID()
}

//Create File Manager func for the REBT data to access the documents Directory
private func getREBTDataFileURL() throws -> URL {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("REBTData.json")
}


//class that stores all the already given sessions to access them everywhere everytime.

class REBTLibrary: ObservableObject {
    @Published var activeSessions: [Session] = []
    
    
    //save the data of activeSessions in Firestore
    
    func addREBTDatainFirestore(session: Session){
        guard let userID = Auth.auth().currentUser?.uid else {
            print ("Error: User is not authenticated, REBT data is not being saved")
            return
        }
        
        //reference to the database
        let db = Firestore.firestore()
        
        let sessionValues : [String: Any] = [
        
            "id": session.id.uuidString,
            "activatingEvent": session.activatingEvent,
            "belief": session.belief,
            "disputation": session.disputation,
            "consequences": session.consequences,
            "effective": session.effective
        ]
        
        db.collection("users").document(userID).collection("sessions").document(session.id.uuidString).setData(sessionValues, merge: true)
    }
    
    //load the data of activeSessions in Firestore
    func loadREBDatainFirestore() {
        //authenticate with the userID
        guard let userID = Auth.auth().currentUser?.uid else {
            print ("Error: User is not authenticated, REBT data is not loading")
            return
        }
        //reference to the database
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).collection("sessions").getDocuments {snapshot, error in
        //Check for errors
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                //no error
                //check what is the userID
                print("Your REBT data for the user ID is: \(userID) has been loaded succesfully")
                //check if snapshot is nil
                if let snapshot = snapshot {
                //Retrieve the documents from Firestore
                    self.activeSessions = snapshot.documents.compactMap { document in
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let activatingEvent = data["activatingEvent"] as? String ?? ""
                        let belief = data["belief"] as? String ??  ""
                        let disputation = data["disputation"] as? String ?? ""
                        let consequences = data["consequences"] as? String ?? ""
                        let effective = data["effective"] as? String ?? ""
                        
                        return Session(activatingEvent: activatingEvent, belief: belief, disputation: disputation, consequences: consequences, effective: effective, id: id)
                        
                        
                        
                    }
                }
                else {
                    print("Snapshot is nil")
                }
            }
            
        }
    }
    
    func deleteREBTDatafromFirestore(session: Session) {
        //reference to the database
        let db = Firestore.firestore()
        
        let sessionValues : [String: Any] = [
        
            "id": session.id.uuidString,
            "activatingEvent": session.activatingEvent,
            "belief": session.belief,
            "disputation": session.disputation,
            "consequences": session.consequences,
            "effective": session.effective
        ]
        
        //Specify the document to delete
        db.collection("sessions").document(session.id.uuidString).delete()
        
        }
        
    }
