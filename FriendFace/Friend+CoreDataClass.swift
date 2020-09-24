//
//  Friend+CoreDataClass.swift
//  FriendFace
//
//  Created by Ginger on 24/09/2020.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case id, name
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init()
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
