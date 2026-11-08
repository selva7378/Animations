//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Remitbee on 04/10/26.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    // Track which flag was tapped (-1 means none tapped yet)
    @State private var selectedFlag = -1

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var alertScoreTitle = ""
    @State private var alertScoreMessage = ""
    @State private var questionCount = 0
    @State private var isGameOverAlert = false
    
    @State private var score = 0

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag: \(questionCount)/8")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation(.spring(duration: 0.8, bounce: 0.4)) {
                                selectedFlag = number
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                        }
                        // Challenge 1: Spin 360 degrees on Y axis
                        .rotation3DEffect(
                            .degrees(selectedFlag == number ? 360 : 0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        // Challenge 2: Fade the unselected flags to 25% opacity
                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                        // Challenge 3: Scale down the unselected flags
                        .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.75)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(alertScoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertScoreMessage)
        }
        .alert("Game Over", isPresented: $isGameOverAlert) {
            Button("Restart", action: reset)
        } message: {
            Text("You scored \(score) out of 8")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            alertScoreTitle = "Correct"
            score += 1
            questionCount += 1
            alertScoreMessage = "Your score is \(score)"
        } else {
            alertScoreTitle = "Wrong"
            questionCount += 1
            alertScoreMessage = "Wrong! That’s the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        if questionCount == 8 {
            isGameOverAlert = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            selectedFlag = -1 // Reset animations for the next question
        }
    }
    
    func reset() {
        questionCount = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false
        alertScoreTitle = ""
        alertScoreMessage = ""
        isGameOverAlert = false
        selectedFlag = -1 // Reset animations for new game
    }
}

#Preview {
    ContentView()
}
