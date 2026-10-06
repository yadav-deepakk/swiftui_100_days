//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct ContentView: View {
    
    var questionCounts = [5, 10, 15, 20]
    
    @State private var gameOn: Bool = false
    @State private var number: Int = 12
    @State private var upto: Int = 10
    @State private var questionCount: Int = 10
    
    @State private var correctCount: Int = 0
    @State private var questionAsked: Int = 0
    @FocusState private var focus: Bool
    @State private var hasEnded: Bool = false
    
    @State private var answer: String = ""
    @State private var degrees: Double = 0.0
    
    @State private var randomNum: Int = 0
    @State private var randomMult: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                if gameOn { playGame }
                else { settings }
            }
        }
        .alert("You've got \(correctCount) correct out of \(questionCount)", isPresented: $hasEnded) {
            Button("OK") { resetGame() }
        } message: { Text("Restart Game") }
    }
    
    // MARK: - Settings
    
    var settings: some View {
        Form {
            Section("Select number and multiplier") {
                Stepper("Table upto number \(number)", value: $number, in: 2...20)
                Stepper("Multiplier upto \(upto)", value: $upto, in: 2...20)
            }
            Section("How many questions you want?") {
                Picker("Question count", selection: $questionCount) {
                    ForEach(questionCounts, id: \.self) { Text("\($0)") }
                }
                .pickerStyle(.segmented)
            }
            HStack {
                Spacer()
                Button("Start Playing") { startGame() }
                Spacer()
            }
        }
        .navigationTitle("Settings")
    }
    
    // MARK: - Game
    
    var playGame: some View {
        Form {
            
            Section("Question \(questionAsked + 1) of \(questionCount)") {
                VStack(spacing: 20) {

                    Text("\(randomNum) × \(randomMult)")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.indigo)
                        .rotation3DEffect(
                            .degrees(degrees),
                            axis: (x: 0, y: 1, z: 0)
                        )
                    
                    TextField("Answer", text: $answer)
                        .focused($focus)
                        .font(.title.bold())
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button("Submit") { submitAnswer() }
                        .buttonStyle(.borderedProminent)
                        .disabled(answer.isEmpty || Int(answer) == nil)
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack {
                Spacer()
                Text("Score: \(correctCount)").font(.title.bold())
                    .contentTransition(.numericText())
                    .animation(.default, value: correctCount)
                Spacer()
            }
            
        }
        .navigationTitle("Multiplication")
    }
    
    // MARK: - Start Game
    
    private func startGame() {
        focus = true
        correctCount = 0
        questionAsked = 0
        answer = ""
        degrees = 0
        
        generateQuestion()
        
        gameOn = true
    }
    
    // MARK: - Generate Question
    
    private func generateQuestion() {
        randomNum = Int.random(in: 2...number)
        randomMult = Int.random(in: 2...upto)
    }
    
    // MARK: - Submit Answer
    
    private func submitAnswer() {
        withAnimation {
            degrees += 360
        }
        
        if let userAnswer = Int(answer) {
            let correctAnswer = randomNum * randomMult
            if userAnswer == correctAnswer {
                correctCount += 1
            }
        }
        
        if questionAsked == questionCount - 1 {
            hasEnded = true
        } else {
            questionAsked += 1
            answer = ""
            generateQuestion()
        }
    }
    
    // MARK: - Reset Game
    
    private func resetGame() {
        number = 12
        upto = 10
        questionCount = 10
        gameOn = false
        hasEnded = false
        correctCount = 0
        questionAsked = 0
        answer = ""
        degrees = 0
        randomNum = 0
        randomMult = 0
    }
}

#Preview {
    ContentView()
}
