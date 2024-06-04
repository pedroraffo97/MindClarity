//
//  GratitudeJournalView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.02.24.
//

import Foundation

import SwiftUI


struct GratitudeJournalView:View {
    @EnvironmentObject var Gratitudedata: GratitudeJournalClass
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    @State var localGratitudeData: GratitudeNote = GratitudeNote(date: "")
    @State var localgratefulListPoint: String = ""
    @State var Gratefulhabit: habit = habit(name: "", done: "", date: "")
    
    private var todaysDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
    
    func addGratefulNotes() {
        let habitname = "Grateful Notes"
        let habitdate = todaysDate
        let habitdone = "🤲"
        Gratefulhabit.name.append(habitname)
        Gratefulhabit.date.append(habitdate)
        Gratefulhabit.done.append(habitdone)
        ProgressTrackingdata.trackedHabits.append(Gratefulhabit)
        
    }
    
    
    var body: some View {
        VStack{
            
            //User Entry part
            VStack{
                HStack{
                    Spacer()
                    TextField("What are you grateful for today?", text: $localgratefulListPoint)
                        .textFieldStyle(.roundedBorder)
                    // When pressing the button the inputted text will be added to the gratefulList and the bulletpoint will be displayed in the VStack
                    Button {
                        localGratitudeData.gratefulList.append(GratefulNote(note: localgratefulListPoint))
                        localgratefulListPoint = "" // erase the TextField when adding a new bullet point.
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding(30)
            }
            .padding(0.1)
            Text("It can be something really simple or complex, but you really need to feel thankful about it.")
                .font(.footnote)
                .padding(5)
                .fontDesign(.rounded)
            
            //gratitude points added ass bullet points looping the content of the class
            ForEach(localGratitudeData.gratefulList){
                index in VStack {
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                        Text(index.note)
                    }
                    .padding(5)
                }
                .transition(.opacity)//transition animation
            }
            .animation(.easeInOut)
            
            //save the created data in the class
            VStack{
                Button {
                    //append todays date for the session
                    localGratitudeData.date.append(todaysDate)
                    
                    Gratitudedata.GratitudeEntries.append(localGratitudeData)
                    localGratitudeData = GratitudeNote(date: "")
                    addGratefulNotes()
                } label: {
                    Text("Add Grateful Session")
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            }
            .padding(30)
            NavigationLink {
                GratitudeJournalLibrary()
                    .navigationTitle("Gratitude Sessions")
            } label: {
                ZStack{
                    HStack{
                        Image(systemName: "checklist.checked")
                        Text("Gratitude Sessions")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    
                }
            }
        }
        .background(chosenWallpaper())
    }
}










struct GratitudeJournalView_Preview: PreviewProvider {
    static var previews: some View {
        GratitudeJournalView()
    }
}
 
