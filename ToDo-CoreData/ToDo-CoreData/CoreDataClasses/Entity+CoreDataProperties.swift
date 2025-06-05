//
//  Entity+CoreDataProperties.swift
//  ToDo-CoreData2
//
//  Created by Umair on 24/05/2025.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var completed: Bool

}

extension ToDoItem : Identifiable {

}
