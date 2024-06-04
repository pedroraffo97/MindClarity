//
//  designMenu.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 27.05.24.
//

import Foundation

import SwiftUI

struct designMenu: View {
    @EnvironmentObject var UserSelection: userSelection
    
    func chooseGreen() {
        UserSelection.preferredDesign = "green"
    }
    
    func chooseMultiColor() {
        UserSelection.preferredDesign  = "multicolor"
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Wallpaper Theme")
            }
            .font(.title2)
            .fontWeight(.heavy)
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
            .bold()
            .padding()
            
            VStack{
                Button {
                    chooseGreen()
                } label: {
                    HStack{
                        Text("Green")
                        Image("greenWallpaper")
                            .resizable()
                            .frame(width: 10.0, height: 10.0)
                            
                    }
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                
                Button {
                    chooseMultiColor()
                } label: {
                    HStack{
                        Text("Multicolor")
                        Image("wallpaper1")
                            .resizable()
                            .frame(width: 10.0, height: 10.0)
                            
                    }
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                
            }
           
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(chosenWallpaper())
    }
}

#Preview {
    designMenu().environmentObject(userSelection())
}
