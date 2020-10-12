//
//  ContentView.swift
//  DiceRoll
//
//  Created by Ginger on 12/10/2020.
//

import SwiftUI

struct ContentView: View {
    var dice = Dice()
    var results = Results()
    
    var body: some View {
        TabView {
            CustomDiceView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Customize")
                }
            
            RollDiceView()
                .tabItem {
                    Image(systemName: "cube")
                    Text("Roll Dice")
                }
            
            ResultsView()
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Results")
                }
        }
        .environmentObject(dice)
        .environmentObject(results)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
