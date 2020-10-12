//
//  Results.swift
//  DiceRoll
//
//  Created by Ginger on 12/10/2020.
//

import SwiftUI

class Result: Identifiable {
    let id = UUID()
    var result = 0
}

class Results: ObservableObject {
    @Published var results: [Result]
    
    init() {
        self.results = []
    }
}
