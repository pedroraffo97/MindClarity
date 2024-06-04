//
//  JournalLibrary.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 16.01.24.
//

import Foundation

import SwiftUI

struct JournalLibraryView: View {
    @EnvironmentObject var Journaldata: JournalLibrary
    @Binding var isShowingJournalLog: Bool
    var body: some View {
            VStack{
                if Journaldata.activeEntry == [] {
                    VStack {
                        Text("No data entries yet")
                            .padding()
                        NavigationLink {NewJournalEntry()} label: {
                            Label("Write", systemImage: "pencil")
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 150, height: 30)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                else {
                    VStack {
                        List{
                            ForEach(Journaldata.activeEntry.indices, id: \.self){ index in
                                let entry = Journaldata.activeEntry[index]
                                // Entry into the journal session
                                NavigationLink {
                                    VStack {
                                        //title
                                        VStack{
                                            TextField(entry.entryTitle,text: $Journaldata.activeEntry[index].entryTitle)
                                        }
                                        .padding()
                                        .font(.title3)
                                        //date
                                        VStack{
                                            TextField(entry.entryDate,text: $Journaldata.activeEntry[index].entryDate)
                                        }
                                        .padding()
                                        .font(.headline)
                                        //text
                                        VStack{
                                            TextEditor(text: $Journaldata.activeEntry[index].entryText)
                                        }
                                        .padding()
                                    }
                                }
                            label: {
                                HStack {
                                    Image(systemName: "book.pages")
                                        .padding()
                                    Grid {
                                        Text(entry.entryDate)
                                            .padding()
                                        TextField(entry.entryTitle,text:$Journaldata.activeEntry[index].entryTitle)
                                            .frame(alignment:.center)
                                            .padding()
                                        
                                    }
                                }
                            }
                                
                            }
                            .onDelete(perform: {
                                indexSet in
                                for index in indexSet {
                                    let entry = Journaldata.activeEntry[index]
                                    Journaldata.deleteJournalDatafromFirestore(entry: entry)
                                }
                                Journaldata.activeEntry.remove(atOffsets:indexSet)
                            })
                        }
                    }
                    .background(chosenWallpaper())
                }
                
            }
            .navigationTitle("Journal Log")
        }
    }

struct JournalLibrary_Preview: PreviewProvider {
    @State static var isShowingJournalLog = true
    static var previews: some View {
        JournalLibraryView(isShowingJournalLog: $isShowingJournalLog).environmentObject(JournalLibrary())
    }
}
