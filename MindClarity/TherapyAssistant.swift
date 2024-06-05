//
//  TherapyAssistant.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.06.24.
//

import Foundation

import OpenAISwift

import SwiftUI

//here we are going to include and adapt all the API for ChatGPT
struct TherapyAssistant: View {
    @State private var inputText = ""
    @State private var outputText = ""
    
    
    private let openAI = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey:""))
    
    func sendMessage() {
        openAI.sendCompletion(with: inputText) {result in
            switch result {
            case .success(let success):
                if let firstChoice = success.choices {
                    outputText = firstChoice.first?.text ?? "No response received from the API."
                            } else {
                                outputText = "No response received from the API."
                            }
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
    
    var body: some View {
        VStack {
            
            TextField("Ask your AI Therapy Assistant", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                sendMessage()
            } label: {
                Text("Send")
            }
            .font(.headline)
            .buttonStyle(.bordered)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("AI Therapist response")
                .font(.headline)
                .padding()
            Text(outputText)
                .padding()
            
        }
    }
}
