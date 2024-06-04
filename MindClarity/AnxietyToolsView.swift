//
//  AnxietyToolsView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 19.01.24.
//

import Foundation

import SwiftUI

struct AnxietyToolsView: View {
    var body: some View {
        VStack {
            List{
                
                NavigationLink {
                    MeditationHubView()
                        .navigationTitle("Meditation Hub")
                } label:{
                    HStack {
                        Image(systemName: "figure.mind.and.body")
                            .padding()
                        Text("Meditation")
                    }
                }
                
                NavigationLink {
                    ReadingContentView()
                        .navigationTitle("Readable Content")
                } label:{
                    HStack {
                        Image(systemName: "books.vertical")
                            .padding()
                        Text("Readable Content")
                    }
                }
                
                NavigationLink {
                    GratitudeJournalView()
                        .navigationTitle("Gratitude Journal")
                } label:{
                    HStack {
                        Image(systemName: "hand.thumbsup.circle.fill")
                            .padding()
                        Text("Gratitude Journal")
                    }
                }
                NavigationLink {
                    ProudView()
                        .navigationTitle("Proud")
                } label:{
                    HStack {
                        Image(systemName: "star.circle")
                            .padding()
                        Text("I'm proud for...")
                    }
                }
            }.navigationTitle("Tools")        }
    }
}

struct AnxietyToolsView_Preview: PreviewProvider {
    static var previews: some View {
        AnxietyToolsView()
    }
}
