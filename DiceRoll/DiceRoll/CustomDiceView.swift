//
//  CustomDiceView.swift
//  DiceRoll
//
//  Created by Ginger on 12/10/2020.
//

import SwiftUI

struct CustomDiceView: View {
    @EnvironmentObject var dice: Dice
    
    @State private var sides = 6
    @State private var quantity = 1
    
    var body: some View {
        NavigationView {
            Form {
                Stepper(value: $sides, in: 4...100) {
                    Text("\(sides) sides")
                }
                
                Stepper(value: $quantity, in: 1...4) {
                    Text("\(quantity)x dice\(quantity == 1 ? "" : "s")")
                }
                
                Button(action: {
                    self.dice.sides = self.sides
                    self.dice.quantity = self.quantity
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle(Text("Customize"))
        }
    }
}

struct CustomDiceView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDiceView()
    }
}
