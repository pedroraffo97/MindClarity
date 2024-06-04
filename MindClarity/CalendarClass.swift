//
//  CalendarClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 12.03.24.
//

import Foundation

import SwiftUI

import FirebaseFirestore

import Firebase

import FirebaseAuth


struct Event: Identifiable, Equatable, Encodable, Decodable {
    var name: String
    var date: Date
    var information: String
    var starttime: Date
    var endtime: Date
    var id: UUID = UUID()
    
    //This initializer is used when you have Date objects ready, typically when creating a new event within the app.
    init(name: String, date: Date, information: String, starttime: Date, endtime: Date, id: UUID = UUID()) {
        self.name = name
        self.date = date
        self.information = information
        self.starttime = starttime
        self.endtime = endtime
        self.id = id
    }
    //This initializer is used when you are loading data from Firestore, where dates are stored as strings.
    init(name: String, dateString: String, information: String, starttimeString: String, endtimeString: String, id: UUID = UUID()) {
        
        self.name = name
        
        if let parsedDate = Event.dateFormatter.date(from: dateString){
            self.date = parsedDate } else {
            print("Error: Invalid date format - \(dateString)")
            self.date = Date()}
        
        self.information = information
        
        if let parsedStartTime = Event.timeFormatter.date(from: starttimeString) {
            self.starttime = parsedStartTime
        } else {
            print("Error: Invalid start time format - \(starttimeString)")
            self.starttime = Date()
        }
        
        if let parsedEndTime = Event.timeFormatter.date(from: endtimeString) {
            self.endtime = parsedEndTime
        } else {
            print("Error: Invalid end time format - \(endtimeString)")
            self.endtime = Date()
        }
        
        self.id = id
    }
    
    
    // Date formatters
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var dateString: String {
        Event.dateFormatter.string(from: date)
    }
    
    var startTimeString: String {
        Event.timeFormatter.string(from: starttime)
    }
    
    var endTimeString: String {
        Event.timeFormatter.string(from: endtime)
    }
    
    
}


class CalendarEvents: ObservableObject {
    @Published var CurrentEvents: [Event] = []
    
    // function to add Events to Firestore
    func addEventtoFirestore(event: Event){
        
        //check authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        
        //declare reference to Firestore
        let db = Firestore.firestore()
        

        
        //create array with keys and values
        let Eventvalues: [String: Any] = [
            
            "id": event.id.uuidString,
            "name": event.name,
            "date": event.dateString,
            "information": event.information,
            "starttime":event.startTimeString,
            "endtime": event.endTimeString
            
            ]
        
        //add the Eventvalues array to Firestore
        db.collection("users").document(userID).collection("calendarEvents").document(event.id.uuidString).setData(Eventvalues, merge: true) {
            error in
            if let error = error {
                print("Error addind document: \(error)")
            } else {
                print("Document succesfully written")
            }
        }
    }
    
    //function to load events from Firestore to the app
    
    func loadEventsfromFirestore(){
        
        //check authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error loading data: User not authenticated")
            return
        }
        
        // Declare a reference to the Firestore cloud
        
        let db = Firestore.firestore()
        
        //load the data from Firestore to the app
        
        db.collection("users").document(userID).collection("calendarEvents").getDocuments{
            snapshot, error in
            if let error = error {
                print("Error loading data: \(error)")
            }
            else {
                if let snapshot = snapshot {
                    self.CurrentEvents = snapshot.documents.compactMap{
                        document in
                        
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let name = data["name"] as? String ?? ""
                        let dateString = data["date"] as? String ?? ""
                        let information = data["information"] as? String ?? ""
                        let startTimeString = data["starttime"] as? String ?? ""
                        let endTimeString = data["endtime"] as? String ?? ""
                        
                        return Event(name: name, dateString: dateString, information: information, starttimeString: startTimeString, endtimeString: endTimeString, id: id)
                    }
                }
            }
        }
    }
    
    func deleteEventfromFirestore(event: Event) {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User is not authenticated")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).collection("calendarEvents").document(event.id.uuidString).delete()
    }
    
}
