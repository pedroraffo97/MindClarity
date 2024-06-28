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
                        .foregroundStyle(Color.white)
                    
                    Button {
                        if let index = ProgressTrackingdata.trackedHabits.firstIndex(where: {$0.id == habitUnit.id}) {
                            ProgressTrackingdata.trackedHabits.remove(at: index)
                            ProgressTrackingdata.deleteHabitsfromFirestore(habit: habitUnit)}
                    } label: {
                        Image(systemName: "trash")}
                    .foregroundColor(.red)
                }
        }
        .padding(5)
    }
}

struct ProgressTrackingView: View {
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    @State var selectedHabitDate: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        return calendar.date(from: components) ?? currentDate
    }()
    
    //Turn the selected date into a String
    var stringdate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedHabitDate)
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
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 40, height: 50))
                            .frame(width: 250, height: 230)
                        VStack{
                        VStack {
                                Text(stringdate)
                                .foregroundStyle(Color.white)
                                .font(.title2)
                                .bold()
                                ForEach(ProgressTrackingdata.trackedHabits.filter{$0.date.isSameDay(as: selectedHabitDate)}){
                                    index in
                                    HabitView(habitUnit: index)
                                }
                            }
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
                        ProgressTrackingdata.addHabit(habitName: "REBT", habitDone: "📝", date: selectedHabitDate)
                        
                    } label: {
                        Text("REBT")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    Button {
                        ProgressTrackingdata.addHabit(habitName: "Meditation", habitDone: "🧘‍♂️", date: selectedHabitDate)
                    } label: {
                        Text("Meditation")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    
                    Button {
                        ProgressTrackingdata.addHabit(habitName: "Journal", habitDone: "📓", date: selectedHabitDate)
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
                        ProgressTrackingdata.addHabit(habitName: "Grateful Notes", habitDone: "🤲", date: selectedHabitDate)
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
