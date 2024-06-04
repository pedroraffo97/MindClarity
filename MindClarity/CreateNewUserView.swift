//
//  CreateNewUserView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 06.05.24.
//

import Foundation


import SwiftUI


struct CreateNewUserView: View {
    @EnvironmentObject var Userdata: UserLibrary
    @State var Local_user_data: User = User(name: "", age: "", photo: "", description: "")
    @State var edit_username: String = ""
    @State var edit_userage: String = ""
    @State var edit_userdescription: String = ""
    @State var edit_photo: String = "imagebackground"
    @Environment (\.dismiss) var dismiss
    
    func attachUserdata() {
        Local_user_data.name.append(edit_username)
        Local_user_data.age.append(edit_userage)
        Local_user_data.description.append(edit_userdescription)
    }
    
    func appendLocalDatatoUserLibrary() {
        Userdata.userDataBase.append(Local_user_data)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                    // user name
                    HStack {
                        Text("Name:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        TextField("", text: $edit_username)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    // user age
                    HStack {
                        Text("Age:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        TextField("", text: $edit_userage)
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
                            .overlay(TextEditor(text: $edit_userdescription)
                                .padding(1)
                            )
                            .foregroundColor(.secondary)
                            .padding(16)
                }
                VStack {
                    Button {
                        attachUserdata()
                        appendLocalDatatoUserLibrary()
                        dismiss()
                    } label: {
                        Text("Save")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.bottom)
                }.padding()
            }
            
        }.navigationTitle("Create New User")
    }
}


#Preview {
    CreateNewUserView()
}
