//
//  activeSessionsView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 09.01.24.
//

import Foundation

import SwiftUI

struct activeSessionsView: View {
    @EnvironmentObject var REBTdata: REBTLibrary
    var body: some View {
        VStack {
            Text("Active Sessions")
                .font(.headline)
                .bold()
            List {
                ForEach(REBTdata.activeSessions.indices, id: \.self) {index in
                    let session = REBTdata.activeSessions[index]
                    NavigationLink {
                        VStack{
                            VStack{
                                Text("Activating Event: ")
                                    .bold()
                                TextField(session.activatingEvent, text: $REBTdata.activeSessions[index].activatingEvent)
                            }
                            .font(.title3)
                            .padding()
                            VStack{
                                Text("Belief: ")
                                    .bold()
                                TextField(session.belief, text: $REBTdata.activeSessions[index].belief)
                            }
                            .padding()
                            VStack{
                                Text("Consequences: ")
                                    .bold()
                                TextField(session.consequences, text: $REBTdata.activeSessions[index].consequences)
                            }
                            .padding()
                            VStack{
                                Text("Disputation: ")
                                    .bold()
                                TextField(session.disputation, text: $REBTdata.activeSessions[index].disputation)
                            }
                            .font(.headline)
                            .padding()
                            VStack{
                                Text("Effective: ")
                                    .bold()
                                TextField(session.effective, text: $REBTdata.activeSessions[index].effective)
                                Text(session.effective)
                            }
                            .padding()
                            
                        }
                    } label: {
                        HStack {
                            Text(session.activatingEvent)
                        }
                    }
                }.onDelete(perform: {
                    indexSet in 
                    for index in indexSet {
                        let session = REBTdata.activeSessions[index]
                        REBTdata.deleteREBTDatafromFirestore(session: session)
                    }
                    REBTdata.activeSessions.remove(atOffsets: indexSet)
                })
            }
        }
        .background(chosenWallpaper())
    }
}

struct activeSessionsView_Preview: PreviewProvider {
    static var previews: some View {
        activeSessionsView()
            .environmentObject(REBTLibrary())
    }
}
