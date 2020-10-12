//
//  ResultsView.swift
//  DiceRoll
//
//  Created by Ginger on 12/10/2020.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var results: Results
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results.results) { result in
                    HStack {
                        Text("\(result.result)")
                    }
                }
            }
            .navigationBarTitle(Text("Previous Rolls"))
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
