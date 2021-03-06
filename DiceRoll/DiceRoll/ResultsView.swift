//
//  ResultsView.swift
//  DiceRoll
//
//  Created by Ginger on 12/10/2020.
//

import SwiftUI

struct ResultsView: View {
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Roll.created, ascending: false)
    ]) var results: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results, id: \.self) { result in
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
