//
//  User+CoreDataProperties.swift
//  taskCoreData
//
//  Created by admin on 18.04.2023.
//
//

import Foundation
import CoreData


extension User {

    @NSManaged public var dateBorn: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var avatar: Data?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
}
//
//extension User : Identifiable {
//
//}
