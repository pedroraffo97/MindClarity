//
//  PDFContainerView.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 23.01.24.
//

import Foundation

import SwiftUI

import PDFKit

//incorporating or using a UIView within a SwiftUI-based interface.
struct PDFContainerView: UIViewRepresentable {
    
    let pdfName: String
    
    //creates and returns an instance of PDFView
    func makeUIView(context: Context) -> PDFView {
        return PDFView()
    }
    //updates the view when the pdfName parameter changes
    func updateUIView(_ uiView: PDFView, context: Context) {
        //Loading the pdf document
        if let pdfURL = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
            //Setting the pdf document
            uiView.document = PDFDocument(url: pdfURL)
        }
    }
}

struct ExampleView: View {
    var body: some View {
        VStack{
            PDFContainerView(pdfName: "anxiety.pdf")
        }
    }
}

struct ExampleView_Preview: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
