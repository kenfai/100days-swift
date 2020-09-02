//
//  Activity.swift
//  HabitTracker
//
//  Created by Ginger on 02/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount: Int = 0
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
