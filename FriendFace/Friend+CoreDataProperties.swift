//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Ginger on 24/09/2020.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    //@NSManaged public var friendOf: User?

    public var wrappedId: String {
        id ?? "Unknown id"
    }
    public var wrappedName: String {
        name ?? "Unknown name"
    }
}

extension Friend : Identifiable {

}
