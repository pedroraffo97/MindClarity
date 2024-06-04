//
//  ProgressTrackingClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 13.02.24.
//

import Foundation


import SwiftUI

import FirebaseAuth
 
import Firebase

import FirebaseFirestore

struct habit: Encodable, Decodable, Hashable, Identifiable {
    var name: String
    var done: String
    var date: String
    var id = UUID()
}

//filemanager
func getFileManagerProgressTracking() -> URL {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("habits.json")
}

class ProgressTrackingClass: ObservableObject {
    @Published var trackedHabits: [habit] = []
    
    
    func addHabitstoFirestore(habit: habit) {
        //check authentication
        guard let userID = Auth.auth().currentUser?.uid 
        else {
            print("Error: User not authenticated")
            return
        }
        
        //reference to Firestore
        let db = Firestore.firestore()
        
        // create the values to be added
        let Habitvalues: [String: Any] = [
        
            "id" :  habit.id.uuidString,
            "name" : habit.name,
            "done" : habit.done,
            "date" : habit.date
        
        ]
        //add array to the "habits" connection in Firestore
        db.collection("users").document(userID).collection("habits").document(habit.id.uuidString).setData(Habitvalues, merge: true)
    }
    
    func loadHabitsfromFirestore(){
    //check authentication
        guard let userID = Auth.auth().currentUser?.uid 
            else {
                print("Error: User not authenticated")
                return
        }
    //create reference
        let db = Firestore.firestore()
    // load data
        db.collection("users").document(userID).collection("habits").getDocuments{
            snapshot, error in
            if let error = error {
                print("Error getting the documents: \(error)")
            }
            else {
                if let snapshot = snapshot {
                    self.trackedHabits = snapshot.documents.compactMap {
                        document in
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let name = data["name"] as? String ?? ""
                        let done = data["done"] as? String ?? ""
                        let date = data["date"] as? String ?? ""
                        
                        return habit(name: name, done: done, date: date, id: id)
                    }
                }
                else {
                    print("snapshot is nil")
                }

            }
        }
    }
    
    func deleteHabitsfromFirestore(habit: habit){
        //authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        //reference
        let db = Firestore.firestore()
        
        //delete habits from collection
        db.collection("users").document(userID).collection("habits").document(habit.id.uuidString).delete()
        
    }
}
