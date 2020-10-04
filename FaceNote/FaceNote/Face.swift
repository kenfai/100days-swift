//
//  Face.swift
//  FaceNote
//
//  Created by Ginger on 03/10/2020.
//

import Foundation

struct Face: Codable, Comparable, Identifiable {
    var id = UUID()
    var photo: String
    var name: String
    var latitude: Double?
    var longitude: Double?
    
    static func < (lhs: Face, rhs: Face) -> Bool {
        return lhs.name < rhs.name
    }
}
