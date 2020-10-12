//
//  RollDiceView.swift
//  DiceRoll
//
//  Created by Ginger on 12/10/2020.
//

import SwiftUI

struct RollDiceView: View {
    @EnvironmentObject var dice: Dice
    @EnvironmentObject var results: Results
    
    @State private var result = 0
    
    
    
    var body: some View {
        VStack {
            HStack {
                    Text("\(self.result)")
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .border(Color.black)
            }
                
            
            Button(action: {
                self.result = 0;
                
                for _ in 1...dice.quantity {
                    self.result += Int.random(in: 1...self.dice.sides)
                }
                
                let newResult = Result()
                newResult.result = self.result
                
                self.results.results.insert(newResult, at: 0)
            }) {
                Text("Roll Dice")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
            .frame(width: 200, height: 100)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 100)
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
