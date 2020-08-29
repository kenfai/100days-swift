//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Ginger on 28/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct Question: View {
    var value: Int
    var multiply: Int

    var question: String {
        "\(value) x \(multiply) = ?"
    }
    var answer: Int {
        value * multiply
    }
    
    var body: some View {
        Text("\(question)")
            .font(.largeTitle)
        
    }
}

enum NumberOfQuestions {
    case five, ten, twenty, all
}

struct ContentView: View {
    @State private var multiplicationTable = 1
    
    @State private var gameActive = false
    @State private var inputAnswer = ""
    
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    
    @State private var score = 0
    @State private var showingScore = false;
    
    var body: some View {
        Group {
            if !self.gameActive {
                Section(header: Text("Which multiplication tables do you want to challenge today?")) {
                    Stepper(value: $multiplicationTable, in: 1...12) {
                        Text("Up to \(multiplicationTable)x table")
                    }
                }
                
                Section(header: Text("How many questions do you want to challenge?")) {
                    HStack(spacing: 60) {
                        Button("5") {
                            self.startGame(NumberOfQuestions.five)
                        }
                        Button("10") {
                            self.startGame(NumberOfQuestions.ten)
                        }
                        Button("20") {
                            self.startGame(NumberOfQuestions.twenty)
                        }
                        Button("All") {
                            self.startGame(NumberOfQuestions.all)
                        }
                    }
                    .padding()
                }
                .alert(isPresented: $showingScore) {
                    Alert(title: Text("Game Over!"), message: Text("Your score is: \(self.score)"), dismissButton: .default(Text("OK")))
                }
            }
            
            if self.gameActive {
                Section {
                    Text("Question \(self.currentQuestion + 1):")
                }
                
                Section {
                     self.questions[self.currentQuestion]
                }
                
                Section {
                    TextField("Answer", text: $inputAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Submit") {
                        self.nextQuestion()
                    }
                }
            }
        }
    }
    
    func startGame(_ numberOfQ: NumberOfQuestions) {
        self.questions = [Question]()
        self.currentQuestion = 0
        self.score = 0
        
        for multiplier in 1...self.multiplicationTable {
            for value in 0...12 {
                self.questions.append(Question(value: value, multiply: multiplier))
            }
        }
        
        self.questions.shuffle()
        
        switch numberOfQ {
        case .five:
            self.questions = Array(self.questions[0..<5])
        case .ten:
            self.questions = Array(self.questions[0..<10])
        case .twenty:
            if self.questions.count < 20 {
                self.questions = Array(self.questions[0..<self.questions.count])
            } else {
                self.questions = Array(self.questions[0..<20])
            }
        default: // .all
            self.questions = Array(self.questions[0..<self.questions.count])
        }
        
        self.gameActive = true
    }
    
    func nextQuestion() {
        if Int(self.inputAnswer) == self.questions[self.currentQuestion].answer {
            score += 1
        }
        self.inputAnswer = ""
        self.currentQuestion += 1

        if self.currentQuestion >= self.questions.count {
            self.endGame()
        }
    }
    
    func endGame() {
        self.gameActive = false
        self.showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
