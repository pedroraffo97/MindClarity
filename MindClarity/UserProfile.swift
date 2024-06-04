//
//  UserProfile.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 07.03.24.
//

import Foundation


import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var Userdata: UserLibrary
    var body: some View {
        ScrollView {
            ForEach(Userdata.userDataBase) { index in
                VStack(alignment: .leading, spacing: 20) {
                    //userPhoto
                    Image(index.photo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding(.top)
                    //users name
                    Text(index.name)
                        .font(.title)
                        .fontWeight(.bold)
                    //user description
                    Text(index.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    //user age
                    HStack {
                        Text("Age:")
                            .padding(.trailing)
                        Text(index.age)
                            .font(.headline)
                            .bold()
                        .foregroundColor(.primary)}
                    //Profile Settings
                    NavigationLink {
                        UserViewEdit()
                    } label: {
                        Text("Edit Profile")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.bottom)
                }
                .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

#Preview {
    UserProfile()
        .environmentObject(UserLibrary())
}
