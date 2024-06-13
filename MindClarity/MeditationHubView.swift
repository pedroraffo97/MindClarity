//
//  MeditationHubView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 19.01.24.
//

import Foundation

import SwiftUI

struct MeditationHubView: View {
    @EnvironmentObject var Meditationdata: MeditationContent
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    @State var Meditationhabit: habit = habit(name: "", done: "", date: Date())
    
    private var todaysDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
    
    func addMeditation() {
        let habitname = "Meditation"
        let habitdone = "🧘‍♂️"
        Meditationhabit.name = habitname
        Meditationhabit.done = habitdone
        ProgressTrackingdata.trackedHabits.append(Meditationhabit)
    }
    
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(Meditationdata.meditation_Content_Videos) {
                    video in
                    VStack {
                        YoutubeVideoPlayer(videoID: video.videoLink)
                            .frame(width: 350, height: 200, alignment: .center)
                            .padding()
                        Text(video.videoName).font(.title3
                        )
                        .padding(5)
                        Text(video.videoDescription)
                        .padding()
                        Button{
                            addMeditation()
                        } label: {
                        Text("add Meditation Session")
                        }
                        .font(.headline)
                        .buttonStyle(.bordered)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .background(chosenWallpaper())
    }
}

struct MeditationHubView_Preview: PreviewProvider {
    static var previews: some View {
        MeditationHubView().environmentObject(MeditationContent())
    }
}
