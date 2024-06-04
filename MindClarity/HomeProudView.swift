//
//  HomeProudView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 26.02.24.
//

import Foundation

import SwiftUI

struct ProudHomeView: View {
    @EnvironmentObject var Prouddata: proudClass
    
    var body: some View {
        ScrollView {
                VStack {
                    HStack{
                        Text("Proud Journal")
                            .font(.title3)
                            .bold()
                            .padding(5)
                        Spacer()
                    }
                }
                if Prouddata.savedProudPoints == [] {
                    NavigationLink{
                        ProudView()
                            .navigationTitle("Proud Journal")
                    } label: {
                        HStack {
                                HStack{
                                    Image(systemName: "star.circle")
                                        .padding()
                                    Text("I'm proud for...")
                                        .padding()
                                }
                                .background(Color.black)
                                .foregroundColor(.white)
                                .font(.headline)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding()
                        }
                    }
                } else {
                    ForEach(Prouddata.savedProudPoints){index in VStack {
                        NavigationLink {
                            ProudView()
                        } label: {
                            HStack {
                                Text("❤️")
                                Text(index.name)
                                    .font(.headline)
                            }
                            .padding(5)
                        }
                    }
                    }
                }
                Rectangle()
                    .frame(height: 1)
            }
    }
    
}

struct ProudHomePreview: PreviewProvider {
    static var previews: some View {
        ProudHomeView().environmentObject(proudClass())
    }
}
