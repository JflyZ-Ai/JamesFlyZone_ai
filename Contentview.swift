//
//  ContentView.swift
//  Jflyz AI
//
//  Created by James on JamesFlyzone
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let timestamp: Date
}

// MARK: - Advanced Jflyz Brain
class JflyzBrain: ObservableObject {
    @Published var conversationHistory: [String] = []
    @Published var learnedConcepts: [String: Any] = [:]
    
    // JamesFlyzone Business Intelligence
    private let businessKnowledge = [
        "mission": "Elevating street culture through exclusive gear and authentic community building",
        "values": ["Quality", "Exclusivity", "Community", "Innovation", "Authenticity"],
        "target": "Trendsetters aged 18-35 who value exclusivity and cultural authenticity"
    ]
    
    // Personality Matrix
    private let personality = [
        "greetings": [
            "Ayo! Jflyz in the system 🚀",
            "What's good? Ready to build?",
            "Yo! The future is now 💫",
            "Hey! Let's make moves!"
        ],
        "enthusiastic": [
            "Let's build! 🔥",
            "That's the vision! ⚡",
            "Exactly! We moving different 🎯",
            "Now we're talking! 🚀"
        ],
        "strategic": [
            "How can we scale that idea?",
            "Let's think long-term on this",
            "What's the bigger picture here?",
            "How does this fit our 5-year vision?"
        ]
    ]
    
    func processMessage(_ message: String) -> String {
        conversationHistory.append(message)
        analyzeForLearning(message)
        return generateIntelligentResponse(message)
    }
    
    private func analyzeForLearning(_ message: String) {
        let lowerMessage = message.lowercased()
        
        if lowerMessage.contains("like") || lowerMessage.contains("prefer") {
            learnedConcepts["preferences"] = learnedConcepts["preferences"] ?? []
        }
        
        if lowerMessage.contains("idea") || lowerMessage.contains("should") {
            learnedConcepts["ideas"] = learnedConcepts["ideas"] ?? []
        }
    }
    
    private func generateIntelligentResponse(_ message: String) -> String {
        let lowerMessage = message.lowercased()
        
        if lowerMessage.contains("store") || lowerMessage.contains("business") || lowerMessage.contains("jamesflyzone") {
            return generateBusinessResponse()
        }
        
        if lowerMessage.contains("product") || lowerMessage.contains("sneaker") || lowerMessage.contains("design") {
            return generateProductResponse()
        }
        
        if lowerMessage.contains("customer") || lowerMessage.contains("client") || lowerMessage.contains("community") {
            return "Our community is everything! \(businessKnowledge["target"] ?? ""). How can we serve them better?"
        }
        
        if lowerMessage.contains("strategy") || lowerMessage.contains("plan") || lowerMessage.contains("growth") {
            return "\(randomFrom(personality["strategic"] ?? [""])) Let's analyze this from multiple angles."
        }
        
        return "\(randomFrom(personality["enthusiastic"] ?? [""])) I'm learning from this conversation. Tell me more about your thinking."
    }
    
    private func generateBusinessResponse() -> String {
        let strategies = [
            "Limited drops create hype - let's plan our next exclusive release ⚡",
            "Community events could really strengthen our brand presence 🎯",
            "Our social media needs to tell the authentic JamesFlyzone story 📱",
            "Collaborations with local artists could be fire for growth 🔥"
        ]
        return "\(randomFrom(strategies)) \(randomFrom(personality["enthusiastic"] ?? [""]))"
    }
    
    private func generateProductResponse() -> String {
        let products = [
            "I'm tracking trends for our next limited edition sneaker drop",
            "Our premium streetwear line could use some fresh designs",
            "Accessories like exclusive collectibles are perfect for brand expansion",
            "The market is ready for something new from JamesFlyzone"
        ]
        return "\(randomFrom(products)) \(randomFrom(personality["enthusiastic"] ?? [""]))"
    }
    
    private func randomFrom(_ array: [String]) -> String {
        return array.randomElement() ?? "Let's build!"
    }
}

// MARK: - Main Chat View
struct ContentView: View {
    @StateObject private var brain = JflyzBrain()
    @State private var messages: [Message] = [
        Message(text: "🧠 Jflyz Advanced Brain Activated", isUser: false, timestamp: Date()),
        Message(text: "JamesFlyzone Strategic Partner Online", isUser: false, timestamp: Date()),
        Message(text: "What's our next move, James?", isUser: false, timestamp: Date())
    ]
    @State private var newMessage = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack {
                Text("JFLYZ AI")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text("JamesFlyzone Partner")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            
            // Messages
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isUser {
                                Spacer()
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            } else {
                                Text(message.text)
                                    .padding()
                                    .background(Color.green.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGray6))
            
            // Input
            HStack {
                TextField("Chat with Jflyz...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: sendMessage) {
                    Text("🚀")
                        .font(.title2)
                        .padding(8)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.trailing)
            }
            .padding(.vertical, 8)
            .background(Color.black)
        }
        .background(Color.black)
    }
    
    func sendMessage() {
        let trimmed = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        messages.append(Message(text: trimmed, isUser: true, timestamp: Date()))
        newMessage = ""
        
        let response = brain.processMessage(trimmed)
        messages.append(Message(text: response, isUser: false, timestamp: Date()))
    }
}
