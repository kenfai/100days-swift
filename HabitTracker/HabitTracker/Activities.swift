//
//  Activities.swift
//  HabitTracker
//
//  Created by Ginger on 02/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(items) {
                UserDefaults.standard.set(data, forKey: "habits")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "habits") {
            if let activities = try? decoder.decode([Activity].self, from: data) {
                items = activities
                return
            }
        }
    }
}
