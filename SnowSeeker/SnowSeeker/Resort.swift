//
//  Resort.swift
//  SnowSeeker
//
//  Created by Ginger on 14/10/2020.
//

import Foundation

struct Resort: Identifiable, Codable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
        // facilities.map { Facility.init(name: $0) }
    }
}
