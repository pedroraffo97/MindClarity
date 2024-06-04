//
//  GratitudeJournalLibrary.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 07.02.24.
//

import Foundation

import SwiftUI

struct GratitudeJournalLibrary: View {
    @EnvironmentObject var Gratitudedata: GratitudeJournalClass
    
    var body: some View {
        VStack {
            List {
                ForEach(Gratitudedata.GratitudeEntries){ data
                    in
                    NavigationLink {
                        VStack {
                            HStack{
                                Text("Date:")
                                    .font(.headline)
                                    .bold()
                                Text(data.date)
                            }
                            .padding()
                            VStack {
                                Text("Grateful:")
                                    .font(.title3)
                                    .bold()
                                    .fontDesign(.default)
                                    .padding()
                                ForEach(data.gratefulList){
                                    note in
                                    VStack{
                                        HStack{
                                            Image(systemName: "checkmark.circle.fill")
                                                .padding()
                                            Text(note.note)
                                        }
                                    }
                                }
                            }
                        }
                    } label: {
                        VStack {
                            HStack {
                                Image(systemName: "bookmark.circle.fill")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding()
                                Text(data.date)
                            }
                        }
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    for index in indexSet {
                        let entry = Gratitudedata.GratitudeEntries[index]
                        Gratitudedata.deleteDatafromFirestore(gratitudeEntry: entry)
                    }
                    Gratitudedata.GratitudeEntries.remove(atOffsets: indexSet)
                })
            }
        }
        .background(chosenWallpaper())
    }
}

struct GratitudeLibrary_Preview: PreviewProvider {
    static var previews: some View {
        GratitudeJournalLibrary().environmentObject(GratitudeJournalClass())
    }
}
