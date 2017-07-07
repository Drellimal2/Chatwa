//
//  Round+CoreDataClass.swift
//  
//
//  Created by QualityWorks on 7/6/17.
//
//

import Foundation
import CoreData

@objc(Round)
public class Round: NSManagedObject {

    convenience init(id: Int, hint: String, answer: String, grid: String, context: NSManagedObjectContext) {
        let entityName = "Round"

        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
            self.init(entity: entity, insertInto: context)
            self.id = Int32(id)
            self.hint = hint
            self.grid = grid
            self.answer = answer
        } else {
            fatalError("Unable to find Entity name: \(entityName)")
        }
    }
}
