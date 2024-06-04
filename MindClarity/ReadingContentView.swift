//
//  ReadingContentView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 23.01.24.
//

import Foundation

import SwiftUI

struct ReadingContentView: View {
    @EnvironmentObject var PDFdata: PDFReadingContent
    
    var body: some View {
        VStack {
            List {
                ForEach(PDFdata.documentLibrary){
                    document in
                    NavigationLink {
                        webContentDisplayView(webContent: document.ReadingWebName)
                            .navigationTitle(document.ReadingTitle)
                    } label: {
                        HStack {
                            Image(systemName: "book.fill")
                                .padding()
                            Text(document.ReadingTitle)
                                .padding()
                        }
                    }
                }
                
            }
        }
    }
}

struct ReadingContentView_Preview: PreviewProvider {
    static var previews: some View {
        ReadingContentView().environmentObject(PDFReadingContent())
    }
}
