//
//  ContentView.swift
//  Trivvy-Remake
//
//  Created by Zayah Cortright on 10/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var questions: [Question] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(questions) { question in
                    // move to QuestionView struct / layout thing
                    NavigationLink(destination: QuestionView(question: question)) {
                        Text(question.question)
                    }
                }
                // Add NavigationLink to QuestionView for each question
            }
            .navigationTitle("Trivvey")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        questions.shuffle()
                    } label: {
                        Image(systemName: "shuffle")
                            .foregroundColor(.black)
                    }
                }
            }
            // Add navigationTitle
            // Add shuffle button in toolbar
        }
        
        .onAppear {
            let url: URL = Bundle.main.url(forResource: "questions", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            // decode the questions
            questions = try! JSONDecoder().decode([Question].self, from: data)
            
        }
    }
    
}

struct QuestionView: View {
    let question: Question
    @State private var selectedAnswer: String = ""
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(question.question)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding()
            
            Button(question.A) {
                selectedAnswer = "A"
            }
            .buttonStyle(.borderedProminent)
            .tint(selectedAnswer == "A" ? (question.answer == "A" ? .green : .red) : .blue)
            
            Button(question.B) {
                selectedAnswer = "B"
            }
            .buttonStyle(.borderedProminent)
            .tint(selectedAnswer == "B" ? (question.answer == "B" ? .green : .red) : .blue)
            
            Button(question.C) {
                selectedAnswer = "C"
            }
            .frame(maxWidth: .infinity)

            .buttonStyle(.borderedProminent)
            .tint(selectedAnswer == "C" ? (question.answer == "C" ? .green : .red) : .blue)
            
            Button(question.D) {
                selectedAnswer = "D"
            }
            .frame(maxWidth: .infinity)

            .buttonStyle(.borderedProminent)
            .tint(selectedAnswer == "D" ? (question.answer == "D" ? .green : .red) : .blue)
            
        }
        .padding()
    }
}

struct Question: Identifiable, Codable { // Codeable for the json decoder
    let id = UUID()
    let question: String
    let A: String
    let B: String
    let C: String
    let D: String
    let answer: String
    
    // solution to the warning regarding coding... tells swift that decoding should skip the id
    enum CodingKeys: String, CodingKey {
        case question, A, B, C, D, answer
    }
    
    var correctAnswerQuestionMark: String {
        switch answer {
        case "A": return A
        case "B": return B
        case "C": return C
        case "D": return D
        default: return A
        }
    }
}

#Preview {
    ContentView()
}
