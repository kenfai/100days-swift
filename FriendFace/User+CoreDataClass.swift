//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Ginger on 24/09/2020.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case id, name, isActive, age, company, email, address, about, registered//, friends, tags
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init()
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        age = try container.decode(Int16.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registered = try container.decode(String.self, forKey: .registered)
        //friends = try container.decode([Friend].self, forKey: .friends)
        //tags = try container.decode([Tag].self, forKey: .tags)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        //try container.encode(friends, forKey: .friends)
        //try container.encode(tags, forKey: .tags)
    }
}
