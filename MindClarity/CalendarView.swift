//
//  CalendarView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 12.03.24.
//

import Foundation


import SwiftUI

//Here it will display the calendar information from the calendar class when selecting an specific date
//When selecting a specific date from the DatePicker it will show the information of the current events on the bottom as a NavigationLink or even showing the whole information of the created Event

struct CalendarView: View {
    @EnvironmentObject var Calendardata: CalendarEvents
    //Create ensure that the selectedDate has the time component erased:
    @State var selectedDate: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        return calendar.date(from: components) ?? currentDate
    }()
    
    
    
    
    var body: some View {
        ScrollView {
            //Display if there are not current events it will show to create a new event.
            VStack{
                if Calendardata.CurrentEvents == [] {
                    VStack {
                        Spacer()
                        NavigationLink {
                            NewCalendarView()
                        } label: {
                            Text("Create New Event")
                        }
                        .buttonStyle(.bordered)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                }
                else {
                    // When using the DatePicker when selecting a specific event, it will show the events that are in that day.
                        VStack {
                            VStack(alignment: .leading) {
                                Text(DateFormatter.localizedString(from: selectedDate,
                                                                   dateStyle: .full,
                                                                   timeStyle: .none))
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            VStack {
                                ForEach(Calendardata.CurrentEvents.filter{ $0.date == selectedDate}) {
                                    index in
                                    EventView(event: index)
                                }
                            }.padding()
                            //Date Picker to select the date for the event
                            VStack{
                                DatePicker("select a Date", selection: $selectedDate, displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                            }
                            .padding()
                            //when selecting a date from the date picker it will return the information from the event
                            VStack {
                                NavigationLink {
                                    NewCalendarView()
                                } label: {
                                    Label("New Event", systemImage: "plus")
                                }
                                .buttonStyle(.bordered)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding()
                                    }
                        .background(chosenWallpaper())
                                }
                            }
                        }
                    }
                }
//struct of the Event structure that will be looped when selecting a specific date.
struct EventView: View {
    @EnvironmentObject var Calendardata: CalendarEvents
    let event: Event
    var body: some View {
        VStack {
            //todays Event displayed
            HStack{
                VStack {
                    Rectangle()
                        .frame(height: 1)
                    Text(event.name)
                        .font(.headline)
                        .padding(10)
                        .bold()
                        .font(.title3)
                        .bold()
                        .padding(10)
                    HStack {
                        // Display only hours and minutes of starttime using DateFormatter
                        Text(DateFormatter.localizedString(from: event.starttime, dateStyle: .none, timeStyle: .short))
                        Text("-")
                        // Display only hours and minutes of endtime using DateFormatter
                        Text(DateFormatter.localizedString(from: event.endtime, dateStyle: .none, timeStyle: .short))
                    }
                    HStack {
                        Text("Information:")
                            .padding()
                        Text(event.information)
                            .fontWeight(.light)
                    }
                    Rectangle()
                        .frame(height: 1)
                    
                }
                VStack {
                    Button {
                        if let index = Calendardata.CurrentEvents.firstIndex(where: {$0.id == event.id}) {
                            Calendardata.CurrentEvents.remove(at: index)
                            Calendardata.deleteEventfromFirestore(event: event)}
                    } label: {
                        Image(systemName: "trash")}
                    .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(CalendarEvents())
}
