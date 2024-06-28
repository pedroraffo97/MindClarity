//
//  NewREBTSession.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.01.24.
//

import Foundation

import SwiftUI

struct NewREBTSession: View {
    @State var new_REBT_session: Session = Session(activatingEvent: "", belief: "", disputation: "", consequences: "", effective: "")
    @State var REBThabit: habit = habit(name: "", done: "", date: Date())
    @EnvironmentObject var REBTdata:  REBTLibrary
    @EnvironmentObject var ProgressTrackingdata: ProgressTrackingClass
    @Environment(\.dismiss) var dismiss
    
    private var todaysDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
    
    
    var body: some View {
        ScrollView{
            VStack {
                
                //Activating Section
                VStack{
                    Text("A: Activating Event")
                        .font(.title2)
                        .bold()
                        .padding()
                    Text(
                        """
                        Briefly summarise the situation as objectively as possible: Critical A: (What I was Most Disturbed About)
                        """)
                    .padding()
                    TextEditor(text: $new_REBT_session.activatingEvent)
                                    .frame(minHeight: 250) // Set a minimum height for the text editor
                                    .border(Color.gray, width: 0.3) // Add a border for better visibility
                                    .padding() // Add some padding for better aesthetics
                    Text("Examples - A can be internal or external, real or imagined. A can be an event in the past, present or future.")
                        .font(.footnote)
                        .padding()
                }
                
                
                //Belief Section
                VStack{
                    Text("B: Belief")
                        .font(.title2)
                        .bold()
                        .padding()
                    Text(
                        """
                        Irrational (Unhelpful/Dysfunctional) Beliefs:
                        """)
                    .padding()
                    TextEditor(text: $new_REBT_session.belief)
                                    .frame(minHeight: 250)
                                    .border(Color.gray, width: 0.3)
                                    .padding()
                    TextField("", text: $new_REBT_session.belief)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Text("To identify Rational Beliefs, Look for: 1. Demands: (must/absolute shoulds/oughts) 2. Awfulizing/Catastrophizing 3. Frustration Intolerance 4. Self-Downing, Other Downing, or Life Downing")
                        .font(.footnote)
                        .padding()
                }
                
                
                
                //Consequences Section
                VStack{
                    Text("C: Consequences")
                        .font(.title2)
                        .bold()
                        .padding()
                    Text(
                        """
                        Major Dysfunctional/Unhealthy Negative Emotion (Feeling):
                        Maladaptive/Unhelpful Behaviour (and/or Action Tendency):
                        """)
                    .padding()
                    TextEditor(text: $new_REBT_session.consequences)
                                    .frame(minHeight: 250)
                                    .border(Color.gray, width: 0.3)
                                    .padding()
                    Text(
                        """
                        Dysfunctional Negative Emotions include: - Anxiety/Fear - Shame/embarrassment - Rage/anger - Guilt - Depression(depressed mood) - Problematic jealously - Problematic envy - Hurt
                        Maladaptive Behaviors include: - Social avoidance  - Not taking care of yourself (not exercising, not resting) - Being aggresive
                        """)
                        .font(.footnote)
                        .padding()
                }
                
                //Disputation Section
                VStack{
                    Text("D: Disputation")
                        .font(.title2)
                        .bold()
                        .padding()
                    Text(
                        """
                        Debate your Irrational (Unhelpful/Dysfunctional) Beliefs:
                        """)
                    .padding()
                    TextEditor(text: $new_REBT_session.disputation)
                                    .frame(minHeight: 250)
                                    .border(Color.gray, width: 0.3)
                                    .padding()
                    Text("To Change Irrational Beliefs, Ask Yourself: - Where is holding this belief getting me? Is it helpful or getting me into trouble? - Where is the evidence to support my irrational belief?: Is it really awful? (as bad as it could be?) Can I really not stand it? Am I really totally bad person? - is it logical? Does it follow from my preferences? - Use methaphorical disputation")
                        .font(.footnote)
                        .padding()
                }
                
                //Effective Section
                VStack{
                    Text("E: Effective")
                        .font(.title2)
                        .bold()
                        .padding()
                    Text(
                        """
                        Rational (Helpful/Functional) Belief
                        """)
                    .padding()
                    TextEditor(text: $new_REBT_session.effective)
                                    .frame(minHeight: 250)
                                    .border(Color.gray, width: 0.3)
                                    .padding()
                    Text("To Think More Rationally, Strive For: 1. Flexible Preferences (I want to do well, but I don't have to do so) 2. Anti-Awfulizing (It may be bad or unfortunate, but it is not awful, and I can still enjoy things) 3. High Frustration Tolerance: (I don't like it but I can stand it, and I can still enjoy many things) 4. Self-Acceptance, Other-Acceptance, Life-Acceptance ( I can accept myself just the way I am, amor fati)")
                        .font(.footnote)
                        .padding()
                }
                
                
                //Save the session
                Button{
                    REBTdata.activeSessions.append(new_REBT_session)
                    ProgressTrackingdata.addHabit(habitName: "REBT", habitDone: "📝", date: Date())
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
            }
            .background(chosenWallpaper())
        }
    }





































struct NewREBTSession_Preview: PreviewProvider {
    static var previews: some View {
        NewREBTSession()
    }
}


