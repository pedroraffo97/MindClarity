//
//  NewJournalEntry.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 16.01.24.
//

import Foundation

import SwiftUI

struct NewJournalEntry: View {
    @State private var localEntry: Entry = Entry(entryTitle: "", entryDate: "", entryText: "")
    @State var localDate: String = ""
    @State var Journalhabit: habit = habit(name: "", done: "", date: "")
    @EnvironmentObject var Journaldata: JournalLibrary
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    @Environment (\.dismiss) var dismiss
    @State var isShowingJournalLog: Bool = false
    
    // Get todays date
    private var todaysDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
    // Create a function that sets the system date if the date is not entered
    func setDate() {
        localDate = todaysDate
        if (localEntry.entryDate == "") {
            localEntry.entryDate.append(localDate)
        }
    }
    
    func addJournal() {
        let habitname = "Journal"
        let habitdate = todaysDate
        let habitdone = "📓"
        Journalhabit.name.append(habitname)
        Journalhabit.date.append(habitdate)
        Journalhabit.done.append(habitdone)
        ProgressTrackingdata.trackedHabits.append(Journalhabit)
    }
    
    
    
    var body: some View {
        VStack {
            //Create a Textfield to add the title of the entry.
            TextField("Title", text: $localEntry.entryTitle)
                .font(.title)
                .padding(.top, 5)
                .padding(.horizontal, 30)
                .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                .foregroundColor(.primary)
                .cornerRadius(10)
            //Create a TextField to display today's date and be able to modify it.
            HStack {
                TextField("\(todaysDate)",text: $localEntry.entryDate)
                    .padding()
                    .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                    .foregroundColor(.primary)
                    
                // Define if you want to modify the date or keep the one that the system gave
                Button {
                    setDate()
                } label: {
                    Text("Confirm date")
                }
                .padding()
                .font(.footnote)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
            }
            .padding(.top, 5)
            .padding(.horizontal, 20)
            //Create a TextEditor to write today's thoughts and experiences.
            TextEditor(text:$localEntry.entryText)
                .font(.custom("Helvetica", size: 17))
                .padding()
                .cornerRadius(6)
            
        }
        .navigationTitle("Journal")
        .background(Color(uiColor: .systemGray6))
        
        .toolbar {
            //Add a new session to the Journal Log
            ToolbarItemGroup(placement: .topBarTrailing){
                Group {
                    Button {
                        Journaldata.activeEntry.append(localEntry)
                        addJournal()
                        dismiss()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                Group {
                    Button("Journal Library") {
                        isShowingJournalLog.toggle()
                    }
                }
            }

        }
        .sheet(isPresented: $isShowingJournalLog) {
            JournalLibraryView(isShowingJournalLog: $isShowingJournalLog)
        }
        .navigationTitle("Journal")
    }
        
}

struct NewJournalEntry_Preview : PreviewProvider {
    static var previews: some View {
        NewJournalEntry()
    }
}
