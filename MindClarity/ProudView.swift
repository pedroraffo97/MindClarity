//
//  ProudView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 24.02.24.
//

import Foundation

import SwiftUI

struct ProudView: View {
    @EnvironmentObject var Prouddata: proudClass
    @State var localProudNotes: proudPoint = proudPoint(name: "" , description: "")
    
    var body: some View {
        ScrollView{
            //title section
            VStack{
                Rectangle()
                    .frame(height: 2.5)
                Text("What are you proud of?")
                    .font(.headline)
                    .foregroundStyle(.background)
                Rectangle()
                    .frame(height: 2.5)
            }
            .background(Color.black)
            //name input section
            VStack{
                TextField("I'm proud of...", text: $localProudNotes.name)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            //description input section
            VStack{
                HStack{
                    Text("Why?")
                        .font(.headline)
                    Spacer()
                }
            }
            .padding()
            VStack{
                TextField("here is why..", text: $localProudNotes.description)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            //Button section
            VStack{
                HStack{
                    Button{
                        Prouddata.savedProudPoints.append(localProudNotes)
                        localProudNotes = proudPoint(name: "", description: "")
                    } label: {
                        HStack{
                            Image(systemName: "plus.circle")
                            Text("Save")
                        }
                    }
                    .font(.headline)
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    Spacer()
                }
            }
            // Display of the proud Points
            VStack {
                Rectangle()
                    .frame(height: 1)
                ForEach(Prouddata.savedProudPoints.indices, id: \.self){
                    i in
                    let index = Prouddata.savedProudPoints[i]
                    VStack {
                        NavigationLink {
                            VStack{
                                Text(index.name)
                                    .padding()
                                Text(index.description)
                                    .padding()
                            }
                        } label: {
                            HStack {
                                Text("❤️")
                                Text(index.name)
                                //erase the proud points
                                Button{
                                    Prouddata.savedProudPoints.remove(at: i)
                                    Prouddata.deleteDatafromFirestore(proudData: index)
                                } label: {
                                    Image(systemName: "delete.left")
                                        .scaledToFit()
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .background(chosenWallpaper())
    }
}

struct ProudPreview: PreviewProvider {
    static var previews: some View {
        ProudView().environmentObject(proudClass())
    }
}
