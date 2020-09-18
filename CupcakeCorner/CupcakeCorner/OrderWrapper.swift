//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ginger on 17/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

class OrderWrapper: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var order = Order()
    
    init() { }
}
