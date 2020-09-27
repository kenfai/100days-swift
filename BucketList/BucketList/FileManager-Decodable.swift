//
//  Bundle-Decodable.swift
//  BucketList
//
//  Created by Ginger on 27/09/2020.
//

import Foundation

extension FileManager {
    func decode<T: Codable>(_ file: String) -> T {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let data = try? Data(contentsOf: paths[0].appendingPathComponent(file)) else {
            fatalError("Failed to load \(file) from FileManager.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from FileManager.")
        }
        
        return loaded
    }
}
