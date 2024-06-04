//
//  UserView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 10.01.24.
//

import Foundation

import SwiftUI
//simple userView for the homepage

struct UserView: View {
    @EnvironmentObject var Userdata: UserLibrary
    var body: some View {
        if Userdata.userDataBase == [] {
            NavigationLink{
                CreateNewUserView()
                    .navigationTitle("Create Profile")
            } label: {
                Text("Create Profile")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        } else {
            ForEach(Userdata.userDataBase) {index in
                VStack {
                    HStack{
                        VStack{
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 4.0)
                                    .padding()
                                    .frame(width: 150)
                                Text(index.photo)
                            }
                        }
                        .padding(.trailing, 30)
                        VStack {
                            Text(index.name)
                                .font(.title3)
                                .bold()
                            Text(index.age)
                                .font(.headline)
                            Text(index.description)
                                .font(.footnote)
                            }
                        }.padding()
                    }
                }
            }
        }
    }

struct UserView_preview: PreviewProvider {
    static var previews: some View {
        UserView().environmentObject(UserLibrary())
    }
}
