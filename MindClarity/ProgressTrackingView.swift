//
//  ProgressTrackingView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 13.02.24.
//

import Foundation

import SwiftUI


struct HabitView: View {
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    let habitUnit: habit
    
    var body: some View {
        VStack{
                HStack{
                    Text(habitUnit.done)
                    Text(habitUnit.name)
                    
                    Button {
                        if let index = ProgressTrackingdata.trackedHabits.firstIndex(where: {$0.id == habitUnit.id}) {
                            ProgressTrackingdata.trackedHabits.remove(at: index)
                            ProgressTrackingdata.deleteHabitsfromFirestore(habit: habitUnit)}
                    } label: {
                        Image(systemName: "trash")}
                    .foregroundColor(.red)
                }
        }
        .padding()
    }
}

struct ProgressTrackingView: View {
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    @State var REBThabit: habit = habit(name: "", done: "", date: Date())
    @State var Meditationhabit: habit = habit(name: "", done: "", date: Date())
    @State var Journalhabit: habit = habit(name: "", done: "", date: Date())
    @State var Gratefulhabit: habit = habit(name: "", done: "", date: Date())
    
    @State var selectedHabitDate: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        return calendar.date(from: components) ?? currentDate
    }()

    
    func addREBT() {
        let habitname = "REBT"
        let habitdate = Date()
        let habitdone = "📝"
        REBThabit.name = habitname
        REBThabit.date = habitdate
        REBThabit.done = habitdone
        ProgressTrackingdata.trackedHabits.append(REBThabit)
        
    }
    
    func addMeditation() {
        let habitname = "Meditation"
        let habitdate = Date()
        let habitdone = "🧘‍♂️"
        Meditationhabit.name = habitname
        Meditationhabit.date = habitdate
        Meditationhabit.done = habitdone
        ProgressTrackingdata.trackedHabits.append(Meditationhabit)
    }
    
    func addJournal() {
        let habitname = "Journal"
        let habitdate = Date()
        let habitdone = "📓"
        Journalhabit.name = habitname
        Journalhabit.date = habitdate
        Journalhabit.done = habitdone
        ProgressTrackingdata.trackedHabits.append(Journalhabit)
    }
    
    func addGratefulNotes() {
        let habitname = "Grateful Notes"
        let habitdate = Date()
        let habitdone = "🤲"
        Gratefulhabit.name = habitname
        Journalhabit.date = habitdate
        Gratefulhabit.done = habitdone
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
                        VStack {
                            ForEach(ProgressTrackingdata.trackedHabits.filter{$0.date.isSameDay(as: selectedHabitDate)}){
                                index in
                                HabitView(habitUnit: index)
                            }
                        }
                        VStack {
                            DatePicker("", selection: $selectedHabitDate, displayedComponents: .date)
                                .datePickerStyle(.graphical)
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
