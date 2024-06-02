//
//  MindClarityApp.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.01.24.
//

import SwiftUI
import FirebaseCore

//The AppDelegate class initializes Firebase services when the app finishes launching.
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}




@main
struct MindClarityApp: App {
    //Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authManager = AuthManager.shared //Add an auth manager
    @StateObject var REBTdata = REBTLibrary()
    @StateObject var Journaldata = JournalLibrary()
    @StateObject var Meditationdata = MeditationContent()
    @StateObject var PDFdata = PDFReadingContent()
    @StateObject var Gratitudedata = GratitudeJournalClass()
    @StateObject var ProgressTrackingdata = ProgressTrackingClass()
    @StateObject var Prouddata = proudClass()
    @StateObject var Stoicdata = PhrasesLibrary()
    @StateObject var Userdata = UserLibrary()
    @StateObject var Calendardata = CalendarEvents()
    
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
            }
            .environmentObject(authManager) //Pass the auth manager to ContentView
            .environmentObject(REBTdata)
            .environmentObject(Journaldata)
            .environmentObject(Meditationdata)
            .environmentObject(PDFdata)
            .environmentObject(Gratitudedata)
            .environmentObject(ProgressTrackingdata)
            .environmentObject(Prouddata)
            .environmentObject(Stoicdata)
            .environmentObject(Userdata)
            .environmentObject(Calendardata)
            //when app launches, load all the saved arrays from the classes stored in the fileManager and in the Cloud Firestore
            .onAppear {
                    REBTdata.loadREBDatainFirestore()
                    Journaldata.loadJournalDatafromFirestore()
                    Gratitudedata.loadGratitudesNotesfromFirestore()
                    ProgressTrackingdata.loadHabitsfromFirestore()
                    Userdata.loadUserDatainFirestore()
                    Calendardata.loadEventsfromFirestore()
                    Prouddata.loadProudDatafromFirestore()
                    }
            }
        //when updating the userID it will update the Firestore data for that current User
        .onChange(of: AuthManager().userID) {
            _ in
            REBTdata.loadREBDatainFirestore()
            Userdata.loadUserDatainFirestore()
            Journaldata.loadJournalDatafromFirestore()
            Gratitudedata.loadGratitudesNotesfromFirestore()
            Prouddata.loadProudDatafromFirestore()
            ProgressTrackingdata.loadHabitsfromFirestore()
            Calendardata.loadEventsfromFirestore()
        }
        //when adding a new session in the REBT active Sessions array it will add it in the Firestore collection
        .onChange(of: REBTdata.activeSessions){_ in
            
            for session in REBTdata.activeSessions {
                REBTdata.addREBTDatainFirestore(session: session)}
        }
        //when adding a new entry in the Journal active Entry array it will add it in the Firestore collection
        .onChange(of: Journaldata.activeEntry){_ in
            
            for entry in Journaldata.activeEntry {
                Journaldata.addJournalDatainFirestore(entry: entry)
            }
        }
        //when adding or changing gratitude entries, they will be added to the Firestore collection
        .onChange(of: Gratitudedata.GratitudeEntries) {_ in
            
            for gratitudeEntry in Gratitudedata.GratitudeEntries {
                Gratitudedata.addGratitudesNotesinFirestore(gratitudeEntry: gratitudeEntry)
            }
        }
        //when adding or changing Proud Points, they will be added to the Firestore collection
        .onChange(of: Prouddata.savedProudPoints) {_ in
            
            for proudPoints in Prouddata.savedProudPoints {
                Prouddata.addProudDatatoFirestore(prouddata: proudPoints)
            }
        }
        
        .onChange(of: ProgressTrackingdata.trackedHabits) {_ in
            
            for habits in ProgressTrackingdata.trackedHabits {
                ProgressTrackingdata.addHabitstoFirestore(habit: habits)
            }
            
            
        }
        
        //when adding or changing information in the Userdatabase array it will add the information in the Firestore collection
        .onChange(of: Userdata.userDataBase) {_ in
            
            for userdata in Userdata.userDataBase {
                Userdata.addUserDatainFirestore(user: userdata)
            }
            
        }
        .onChange(of: Calendardata.CurrentEvents) {_ in
            
            for events in Calendardata.CurrentEvents {
                Calendardata.addEventtoFirestore()
            }
            
        }
    }
}
