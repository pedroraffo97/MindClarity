//
//  MenuView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 09.01.24.
//

import Foundation

import SwiftUI

struct MenuView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Home")
                }
            
            REBTView()
                .tabItem {
                    Image(systemName: "square.on.square.badge.person.crop")
                    Text("REBT Sessions")
                }
            JournalView()
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Journal")
                }
            AnxietyToolsView()
                .tabItem {
                    Image(systemName: "gym.bag")
                    Text("Tools")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
        }
    }
}


struct MenuView_Preview: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(REBTLibrary())
            .environmentObject(ProgressTrackingClass())
            
    }
}
