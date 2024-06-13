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
    var date: Date
    var id = UUID()
    
        
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var dateString: String {
        habit.dateFormatter.string(from: date)
    }
    
    init(name: String, done: String, date: Date, id: UUID = UUID()) {
        self.name = name
        self.done = done
        self.date = date
        self.id = id
    }
    
    init(name: String, done: String, dateString: String, id: UUID = UUID()) {
        self.name = name
        self.done = done
        
        if let parsedDate = habit.dateFormatter.date(from: dateString){
            self.date = parsedDate
        } else {
            print("Error: Invalid date format - \(dateString)")
            self.date = Date()
        }
        
        self.id = id
    }
    
}

extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
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
            "date" : habit.dateString
        
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
                        let dateString = data["date"] as? String ?? ""
                        
                        return habit(name: name, done: done, dateString: dateString, id: id)
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
