//
//  UserViewEdit.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.03.24.
//

import Foundation

import SwiftUI

struct UserViewEdit: View {
    @EnvironmentObject var Userdata: UserLibrary
    
    var body: some View {
        ScrollView {
            VStack {
                //user name
                ForEach(Userdata.userDataBase.indices, id: \.self) {
                    index in
                    let userdata = Userdata.userDataBase[index]
                    HStack {
                        Text("Name:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        TextField(userdata.name, text: $Userdata.userDataBase[index].name)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    // user age
                    HStack {
                        Text("Age:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        TextField(userdata.age, text: $Userdata.userDataBase[index].age)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    // user description
                    VStack {
                        Text("Describe yourself shortly:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        //Box with Texteditor
                        RoundedRectangle (cornerRadius: 10)
                            .frame(height: 150)
                            .overlay(TextEditor(text: $Userdata.userDataBase[index].description)
                                .padding(1)
                            )
                            .foregroundColor(.secondary)
                            .padding(16)
                    }
                    VStack {
                        Button {
                            Userdata.deleteUserDatafromFirestore(user: userdata)
                            Userdata.userDataBase.remove(at: index)
                        } label: {
                            HStack {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }.padding(.bottom)
                    }.padding()
                }
            }
            
        }
        .navigationTitle("Edit Profile")
        .background(chosenWallpaper())
    }
}


#Preview {
    UserViewEdit()
}
