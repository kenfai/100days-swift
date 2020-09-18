//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ginger on 18/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct Order: Codable {
    var type = 0
    var quantity = 3
    
    var extraFrosting = false
    var addSprinkles = false
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var name = ""
    var streetAddress = ""
    var city = ""
    var postcode = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || postcode.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // Complicated cake costs more
        cost += (Double(type) / 2)
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 / cake for sprinkles
        if addSprinkles {
            cost += (Double(quantity) / 2)
        }
        
        return cost
    }
}
