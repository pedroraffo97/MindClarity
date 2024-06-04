//
//  JournalView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 10.01.24.
//

import Foundation

import SwiftUI

struct JournalView: View {
    @State private var isShowingJournalLog = false
    var body: some View {
        VStack(alignment: .center) {
            Text("Journal")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding()
            List {
                NavigationLink {
                    NewJournalEntry()
                        .navigationTitle("New Entry")
                } label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Entry")}
                }
                .padding(5)
                NavigationLink {
                    JournalLibraryView( isShowingJournalLog: $isShowingJournalLog)
                        .navigationTitle("Journal Library")
                } label: {
                    HStack{
                        Image(systemName: "tray.full.fill")
                        Text("Journal Library")}
                }
                .padding(5)
            }
        }
    }
}

struct JournalView_Preview: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
