//
//  Round+CoreDataProperties.swift
//  
//
//  Created by QualityWorks on 7/6/17.
//
//

import Foundation
import CoreData


extension Round {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Round> {
        return NSFetchRequest<Round>(entityName: "Round")
    }

    @NSManaged public var answer: String?
    @NSManaged public var grid: String?
    @NSManaged public var hint: String?
    @NSManaged public var id: Int32

}
