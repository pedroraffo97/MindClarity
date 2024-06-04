//
//  ReadingContentClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 23.01.24.
//

import Foundation

import SwiftUI

struct webSingleFile: Identifiable, Encodable, Decodable, Hashable {
    var ReadingWebName: String
    var ReadingTitle: String
    var id: UUID = UUID()
}

class PDFReadingContent: ObservableObject {
    @Published var documentLibrary: [webSingleFile] = [
    anxiety_introduction,
    depression_description
    ]
}

var anxiety_introduction = webSingleFile(ReadingWebName: "https://www.iom.int/sites/g/files/tmzbdl486/files/staff-welfare/anxiety.pdf", ReadingTitle: "Introduction to Anxiety")

var depression_description = webSingleFile(ReadingWebName: "https://www.psychiatry.org/patients-families/depression/what-is-depression", ReadingTitle: "What is Depression?")

