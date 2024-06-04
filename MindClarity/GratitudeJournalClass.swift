//
//  GratitudeJournalClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.02.24.
//

import Foundation

import SwiftUI

import Firebase

import FirebaseAuth

import FirebaseFirestore

struct GratefulNote: Identifiable, Hashable, Decodable, Encodable {
    var id = UUID()
    var note: String
}


struct GratitudeNote: Identifiable, Decodable, Encodable, Hashable {
    var date: String
    var gratefulList: [GratefulNote] = []
    var id = UUID()
}

// function to call the filemanager to save the gratitude entries in the documents directory.

func getFileManagerGratitudeData() -> URL{
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("GratitudeData.json")
}



class GratitudeJournalClass: ObservableObject {
    @Published var GratitudeEntries: [GratitudeNote] = []
    
    //create functions to set and get data in Firestore
    
    //function to set data in Firestore
    
    func addGratitudesNotesinFirestore(gratitudeEntry: GratitudeNote) {
        //check Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("user not found: Data could not be added")
            return
        }
        //include a reference to the Firestore
        let db = Firestore.firestore()
        
        //convert GratefulList into an array of dictionaries
        let gratefulListData = gratitudeEntry.gratefulList.map {
            gratefulNote in
            return  [
                "note": gratefulNote.note
            ]
        }
        
        //set values to save in Firestore
        
        let entryValues: [String: Any] = [
            "id": gratitudeEntry.id.uuidString,
            "date": gratitudeEntry.date,
            "gratefulList": gratefulListData
        ]
        //add the data in the Firestore collection
        
        db.collection("users").document(userID).collection("gratitudeEntries").document(gratitudeEntry.id.uuidString).setData(entryValues, merge: true)
    }
    
    //function to get data from Firestore
    
    func loadGratitudesNotesfromFirestore() {
        //check Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Authentication not succesful, gratitude data could not be loaded")
            return
        }
        
        //reference to the Firestore
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).collection("gratitudeEntries").getDocuments{
            snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            
            else
            
            {
                if let snapshot = snapshot {
                    //retrieve data from collection
                    self.GratitudeEntries = []
                    //Create a loop to iterate over all the document
                     for document in snapshot.documents {
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let date = data["date"] as? String ?? ""
                        
                        //retrieve gratefulList as an array of dictionaries
                        guard let gratefulListData = data["gratefulList"] as? [[String: Any]] else {
                            //return nil if gratefulList is not a list of dictionaries
                            continue
                        }
                        //decode each dictionary into GratefulNote object
                        let gratefulList: [GratefulNote] = gratefulListData.compactMap {
                            gratefulData in
                            guard let note = gratefulData["note"] as? String else {
                                return nil
                            }
                            return GratefulNote(note: note)
                        }
                        
                        let gratitudeNote = GratitudeNote(date: date, gratefulList: gratefulList, id: id)
                        self.GratitudeEntries.append(gratitudeNote)
                    }
                }
                else {
                    print("Snapshot is nil")
                }
            }
        }
        
    }
    
    //function to delete the gratitudeData from the Firestore
    
    func deleteDatafromFirestore(gratitudeEntry: GratitudeNote) {
        
        //revise Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error by deleting data: Authentication not possible")
            return
        }
        
        //reference to the Firestore
        let db = Firestore.firestore()
        
        // delete the documents from Firestore
        db.collection("users").document(userID).collection("gratitudeEntries").document(gratitudeEntry.id.uuidString).delete()
    }
    
    
}
