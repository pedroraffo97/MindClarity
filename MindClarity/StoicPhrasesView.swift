//
//  StoicPhrasesView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 29.02.24.
//

import Foundation

import SwiftUI

struct StoicPhrasesView: View {
    @State private var currentCode = 1
    @EnvironmentObject var Stoicdata: PhrasesLibrary
    
    func turnCode() {
        self.currentCode = (self.currentCode + 1) % self.Stoicdata.phrasesArray.count
    }
    
    var body: some View {
            VStack{
                ScrollView{
                    HStack{
                        Text("Stoic Reflections")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(5)
                        Spacer()
                    }
                    ForEach(Stoicdata.phrasesArray) {
                        
                        index in
                        
                        if currentCode == index.code {
                            VStack{
                                Text(index.phrase)
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .padding()
                                
                                HStack{
                                    Button{
                                        turnCode()
                                    } label: {
                                        Image(systemName: "repeat.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.black)
                                            
                                    }
                                    .padding(.leading, 50.0)
                                    Spacer()
                                    Text(index.autor)
                                        .padding(.trailing, 50.0)
                                        .bold()
                                        .font(.footnote)
                                }
                            }
                        }
                }
            }
                Rectangle()
                    .frame(height: 1)
        }
    }
}

struct StoicPhrases_preview: PreviewProvider {
    static var previews: some View {
        StoicPhrasesView().environmentObject(PhrasesLibrary())
    }
}
