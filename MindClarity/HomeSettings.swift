//
//  HomeSettings.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 16.05.24.
//

import Foundation

import SwiftUI

struct HomeSettings: View {
    var body: some View {
        NavigationLink {
            AppSettings()
        } label: {
            Label("Settings",systemImage:"gearshape")
        }
        .buttonStyle(.bordered)
        .background(Color.black)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    HomeSettings()
}
