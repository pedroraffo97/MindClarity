//
//  ContentView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.01.24.
//

import Foundation

import SwiftUI

struct ContentView: View {
    @StateObject var authManager = AuthManager.shared
    
    var body: some View {
        Group {
            if authManager.isUserAuthenticated() {
                    MenuView()
                }
            else {
                    UserSignIn()
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

