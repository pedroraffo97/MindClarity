//
//  JournalClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 16.01.24.
//

import Foundation

import Firebase

import FirebaseAuth

import FirebaseFirestore

//create single identifiable structs that are going to store the information of each of the journal session.

struct Entry: Identifiable, Encodable, Decodable, Hashable {
    var entryTitle: String
    var entryDate: String
    var entryText: String
    var id: UUID = UUID()
}
//Create a func to access the documents directory to store the Journal Data
private func getJournalDataFileURL() -> URL {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("JournalData.json")
}


//class that stores all the different entries that the user has made in the app.

class JournalLibrary: ObservableObject {
    @Published var activeEntry: [Entry] = []
    // functions to save and load data in Firestore
    
    //function to add data in Firestore
    
    func addJournalDatainFirestore(entry: Entry) {
        //authenticate with the userID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User is not authenticated, Journal data could not be saved")
            return
        }
        
        //reference to the database
        
        let db = Firestore.firestore()
        
        //define the different keys and values
        
        let entryValues : [String: Any] = [
        
            "id": entry.id.uuidString,
            "entryTitle": entry.entryTitle,
            "entryDate": entry.entryDate,
            "entryText": entry.entryText
        ]
        //add the data in the firestore collection
        
        db.collection("users").document(userID).collection("journal").document(entry.id.uuidString).setData(entryValues, merge: true)
        
    }
    
    // function to get the Journal Data from Firestore
    func loadJournalDatafromFirestore() {
        //authenticate the current User
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User is not authenticated, Journal data could not be called")
            return
        }
        
        //reference to the database
        
        let db = Firestore.firestore()
        
        //get the data from the Firestore collection
        db.collection("user").document(userID).collection("journal").getDocuments {
            snapshot, error in
            //Check for errors
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else { // error = nil or no errors
                //Check the current User (userID) of the loaded Journal data
                print("The Journal data of the userID: \(userID) has been called succesfully")
                //Check if snapshot is nil
                if let snapshot = snapshot {
                    //Retrieve the documents from Firestore
                    self.activeEntry = snapshot.documents.compactMap {
                        document in
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let entryTitle = data["entryTitle"] as? String ?? ""
                        let entryDate = data["entryDate"] as? String ?? ""
                        let entryText = data["entryText"] as? String ?? ""
                        
                        return Entry(entryTitle: entryTitle, entryDate: entryDate, entryText: entryText, id: id)
                    }
                    
                }
                else {
                    print("Snapshot is nil")
                }
                
            }
        }
    }
    
    //function to delete the data from Firestore
    func deleteJournalDatafromFirestore(entry: Entry) {
        //authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User is not authenticated, Journal data could not be deleted")
            return
        }

        
        //reference to the database
        let db = Firestore.firestore()
        
        //define the keys and values
        
        let entryValues : [String: Any] = [
            "id": entry.id.uuidString,
            "entryTitle": entry.entryTitle,
            "entryDate": entry.entryDate,
            "entryText": entry.entryText
        ]
        
        //Delete the documents from the collection
        db.collection("users").document(userID).collection("journal").document(entry.id.uuidString).delete()
    }
    
    
}
