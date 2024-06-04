//
//  ProgressTrackingView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 13.02.24.
//

import Foundation

import SwiftUI

struct ProgressTrackingView: View {
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    @State var REBThabit: habit = habit(name: "", done: "", date: "")
    @State var Meditationhabit: habit = habit(name: "", done: "", date: "")
    @State var Journalhabit: habit = habit(name: "", done: "", date: "")
    @State var Gratefulhabit: habit = habit(name: "", done: "", date: "")
    
    private var todaysDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
    
    func addREBT() {
        let habitname = "REBT"
        let habitdate = todaysDate
        let habitdone = "📝"
        REBThabit.name = habitname
        REBThabit.date = habitdate
        REBThabit.done = habitdone
        ProgressTrackingdata.trackedHabits.append(REBThabit)
        
    }
    
    func addMeditation() {
        let habitname = "Meditation"
        let habitdate = todaysDate
        let habitdone = "🧘‍♂️"
        Meditationhabit.name = habitname
        Meditationhabit.date = habitdate
        Meditationhabit.done = habitdone
        ProgressTrackingdata.trackedHabits.append(Meditationhabit)
    }
    
    func addJournal() {
        let habitname = "Journal"
        let habitdate = todaysDate
        let habitdone = "📓"
        Journalhabit.name.append(habitname)
        Journalhabit.date.append(habitdate)
        Journalhabit.done.append(habitdone)
        ProgressTrackingdata.trackedHabits.append(Journalhabit)
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
            Rectangle()
                .frame(height: 1)
            HStack{
                Text("Progress Tracking")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(5)
                Spacer()
            }
                
            Rectangle()
                .frame(height: 5)
            ScrollView{
                VStack{
                    ZStack{
                        VStack{
                            ForEach(ProgressTrackingdata.trackedHabits.indices, id: \.self) {
                                index in 
                                
                                let habit = ProgressTrackingdata.trackedHabits[index]
                                
                                ZStack{
                                    Rectangle()
                                        .scaledToFit()
                                        .frame(width: 300, height: 50)
                                        .colorInvert()
                                        .border(Color.black)
                                    HStack{
                                        Text(habit.done)
                                        Text(habit.date + ":")
                                        Text(habit.name)
                                        Button{
                                            ProgressTrackingdata.trackedHabits.remove(at: index)
                                            ProgressTrackingdata.deleteHabitsfromFirestore(habit: habit)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Rectangle()
                .frame(height: 5)
            
            Text("Select the habits you have done today")
            VStack{
                HStack {
                    Button {
                        addREBT()
                        
                    } label: {
                        Text("REBT")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    Button {
                        addMeditation()
                    } label: {
                        Text("Meditation")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    
                    Button {
                        addJournal()
                    } label: {
                        Text("Journal")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
                
                
                    Button {
                        addGratefulNotes()
                    } label: {
                    Text("Grateful Notes")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()

                }
            }
            Rectangle()
            .frame(height: 1)
        }
    }


struct ProgressTrackingPreview: PreviewProvider {
    static var previews: some View {
        ProgressTrackingView().environmentObject(ProgressTrackingClass())
    }
}
