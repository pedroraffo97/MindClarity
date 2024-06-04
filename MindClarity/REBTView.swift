//
//  REBTView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 10.01.24.
//

import Foundation

import SwiftUI

struct REBTView: View {
    var body: some View {
        VStack{
            Text("Rational emotive behavior therapy (REBT)")
            List {
                //new REBT Session
                NavigationLink {
                    NewREBTSession()
                        .navigationTitle("New REBT Session")
                } label: {
                    Image(systemName: "doc.badge.plus")
                    Text("Create new REBT session")
                }
                //active REBT Sessions
                NavigationLink {
                    activeSessionsView()
                } label: {
                    Image(systemName: "tray.full.fill")
                    Text("Active REBT Sessions")
                }
            }
        }
        .background(chosenWallpaper())
    }
}



struct REBTView_Preview: PreviewProvider {
    static var previews: some View {
        REBTView()
    }
}
