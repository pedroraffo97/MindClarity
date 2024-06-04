//
//  ClearLocalData.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 25.04.24.
//

import Foundation


func clearJournalLocalData() {
    do {
        //Encode the [Session] array to String Data
        let sessionsData = try JSONEncoder().encode(JournalLibrary().activeEntry)
        // Remove the encoded String Data from UserDefaults
        UserDefaults.standard.removeObject(forKey: "activeEntry" )
        print("active Entry Data succesfully cleaned")
        
    } catch {
        print("Error clearing local data: \(error)")
    }
}

func clearREBTLocalData() {
    do {
        //Encode the [Session] array to String Data
        let sessionsData = try JSONEncoder().encode(REBTLibrary().activeSessions)
        // Remove the encoded String Data from UserDefaults
        UserDefaults.standard.removeObject(forKey: "activeSessions" )
        
    } catch {
        print("Error clearing local data: \(error)")
    }
}

func clearUserDataLocalData() {
    do {
        let userData = try JSONEncoder().encode(UserLibrary().userDataBase)
        UserDefaults.standard.removeObject(forKey: "userDataBase")
    }
    catch {
        
    }
}


func clearLocalData() {
    clearREBTLocalData()
    clearUserDataLocalData()
    clearJournalLocalData()
}
