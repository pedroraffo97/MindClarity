//
//  NewCalendarView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 12.03.24.
//

import Foundation


import SwiftUI



struct NewCalendarView: View {
    @EnvironmentObject var Calendardata: CalendarEvents
    @State var selectedDate = Date()
    @State var selectedEvent: String = ""
    @State var selectedInformation: String = ""
    @Environment (\.dismiss) var dismiss
    
    @State var selectedStart: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.hour, .minute], from: currentDate)
        return calendar.date(from: components) ?? currentDate
    }()
    @State var selectedEnd: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.hour, .minute], from: currentDate)
        return calendar.date(from: components) ?? currentDate
    }()
    
    func appendlocalEvent() {
        // Remove the time component from the date
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        guard let dateWithoutTime = calendar.date(from: dateComponents) else {
            print("Date conversion failed")
            return
        }
        //Combine date without time with the selected start and end times
        let startTimeComponents = calendar.dateComponents([.hour, .minute], from: selectedStart)
        
        let endTimeComponents = calendar.dateComponents([.hour, .minute], from: selectedEnd)
        
        dateComponents.hour = startTimeComponents.hour
        dateComponents.minute = startTimeComponents.minute
        
        guard let combinedStartTime = calendar.date(from: dateComponents) else {
            print("Start time conversion failed")
            return
        }
        
        dateComponents.hour = endTimeComponents.hour
        dateComponents.minute = endTimeComponents.minute
        
        guard let combinedEndTime = calendar.date(from: dateComponents) else {
                    print("End time conversion failed")
                    return
                }

        //Create a new Event instance
        let newEvent = Event(name: selectedEvent, date: dateWithoutTime, information: selectedInformation, starttime: combinedStartTime, endtime: combinedEndTime)
        
        
        //append newEvent to the CalendarClass array
        Calendardata.CurrentEvents.append(newEvent)
        Calendardata.addEventtoFirestore(event: newEvent)
        
        //optional: reset the local variables after adding the event
        selectedEvent = ""
        selectedInformation = ""
        print("Event appended")
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                //Select date
                VStack {
                    HStack(alignment:.top){
                        Text("Select date")
                            .font(.title3)
                        .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                    }
                    VStack{
                        Text("\(selectedDate)")
                    }
                }.padding()
                
                //select title of the event
                VStack {
                    HStack {
                        Text("Title of the event: ")
                            .font(.headline)
                        TextField("", text: $selectedEvent)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                }
                //select starting and finish time
                VStack {
                    HStack {
                        Text("Event time:")
                            .font(.headline)
                           
                    Spacer()
                    }
                    HStack {
                        Text("From:")
                        DatePicker("", selection: $selectedStart, displayedComponents: .hourAndMinute)
                            .padding(5)
                        Text("To:")
                        DatePicker("", selection: $selectedEnd, displayedComponents: .hourAndMinute)
                    }
                }
                .padding(40)
                
                //select information of the event
                VStack {
                    HStack {
                        Text("Information:")
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                    
                    VStack {
                        TextEditor(text:$selectedInformation)
                                .frame(width: 350, height: 200)
                                .padding()
                                .background(Color(uiColor: .systemGray6))
                                .cornerRadius(8)
                    }
                    
                    VStack {
                        Button{
                            appendlocalEvent()
                            dismiss()
                        } label: {
                            Text("Save")
                        }
                        .font(.headline)
                        .buttonStyle(.bordered)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                }
                
            }
        }
        .navigationTitle("New Event")
        .background(chosenWallpaper())
    }
}



#Preview {
    NewCalendarView()
}
