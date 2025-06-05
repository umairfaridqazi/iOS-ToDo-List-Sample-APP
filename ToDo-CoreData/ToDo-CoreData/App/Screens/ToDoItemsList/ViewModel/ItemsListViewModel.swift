//
//  ItemsListViewModel.swift
//  ToDo-CoreData2
//
//  Created by Umair on 24/05/2025.
//


protocol ItemsListViewModelProtoCol{
    func create(name: String, completed: Bool)
    func update(item: ToDoItem, name:String, completed:Bool)
    func remove(item:ToDoItem)
    func getAllItems()
}


class ItemsListViewModel: ItemsListViewModelProtoCol{
    
    private let manager : ToDoDbManager
    var items : [ToDoItem] = []
    
    init(manager: ToDoDbManager) {
        self.manager = manager
    }

    
    func create(name: String, completed: Bool) {
        manager.create(name: name, completed: completed)
    }
    
    func update(item: ToDoItem, name: String, completed: Bool) {
        manager.update(item: item, name: name, completed: completed)
    }
    
    func remove(item: ToDoItem) {
        manager.remove(item: item)
    }
    
    func getAllItems() {
        items = manager.getAllItems() ?? []
    }
}
