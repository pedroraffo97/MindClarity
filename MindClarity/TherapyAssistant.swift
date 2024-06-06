//
//  TherapyAssistant.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 05.06.24.
//

import Foundation

import SwiftUI


struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case gpt
}

extension ChatMessage {
    static let sampleMessages = [
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dateCreated: Date(), sender: .gpt),
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dateCreated: Date(), sender: .gpt)
    ]
}

struct TherapyAssistant: View {
    @State var chatMessages: [ChatMessage] = ChatMessage.sampleMessages
    @State var messageText: String = ""
    
    func messageView(message: ChatMessage) -> some View {
        
        HStack {
            
            if message.sender == .me {
                Spacer()
            }
            
            Text(message.content)
                .foregroundColor(message.sender == .me ? .white : .black)
                .padding()
                .background(message.sender == .me ? .black : .gray.opacity(0.1))
                .cornerRadius(16)
            
            if message.sender == .gpt {
                Spacer()
            }
            
        }
    }
    
    func sendMessage() {
        messageText = ""
        print(messageText)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(chatMessages, id: \.id) { message in
                        messageView(message: message)
                    }
                }
            }
            HStack {
                TextField("Write something to the AI Therapist", text: $messageText)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                Button {
                    sendMessage()
                } label: {
                    Text("Send")
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius (10)
                
            }
            
        }
        .padding()
    }
}











#Preview {
    TherapyAssistant()
}
