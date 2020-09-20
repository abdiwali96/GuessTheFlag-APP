//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Abdiwali Abdi on 19/09/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var  showingAlert = false
    @State private var countries = ["Estonia", "France" , "Germany", "Ireland" , "Italy" , "Nigeria" , "Russia" , "Spain" , "UK" , "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var Score : Int = 0
    @State private var Statement : String = ""
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30){
                VStack {
                    Text("TAP THE FLAG")
                        .foregroundColor(.white)
                        .font(.headline)
                        .offset(y: -30)
                        .padding(2)
                    Text(self.countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .offset(y: -30)
                }
                ForEach(0 ..< 3) { number in
                    Button (action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius:5)
                    }
                }
                Text("SCORE: \(Score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .offset(y:20)
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("\(Statement)" ), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.Score += 1
            Statement = "yes, it was \(countries[number])"
        }else {
            scoreTitle = "Wrong"
            Statement = "No, it was \(countries[number])"
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
