//
//  ToDoDbManager.swift
//  ToDo-CoreData2
//
//  Created by Umair on 24/05/2025.
//

import CoreData

protocol ToDoDbManagerProtocol{
    func create(name: String, completed: Bool)
    func update(item: ToDoItem, name:String, completed:Bool)
    func remove(item:ToDoItem)
    func getAllItems() -> [ToDoItem]?
}

class ToDoDbManager: ToDoDbManagerProtocol{
    
    var context : NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(name: String, completed: Bool) {
        let item = ToDoItem(context: context)
        item.name = name
        item.completed = completed
        
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func update(item: ToDoItem, name: String, completed: Bool) {
        item.name = name
        item.completed = completed
        
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func remove(item: ToDoItem) {
        context.delete(item)
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func getAllItems() -> [ToDoItem]? {
        do{
            return try context.fetch(ToDoItem.fetchRequest())
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    
}
