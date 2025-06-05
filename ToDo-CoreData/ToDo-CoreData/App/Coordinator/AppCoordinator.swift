//
//  AppCoordinator.swift
//  ToDo-CoreData2
//
//  Created by Umair on 24/05/2025.
//

import UIKit

class AppCoordinator: Coordinator{
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]?
    
    init(navigationController: UINavigationController, childCoordinators: [Coordinator]? = nil) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ItemsListViewController") { coder in
            return ItemsListViewController(coder: coder, viewModel: ItemsListViewModel(manager: ToDoDbManager(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)))
        }
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToAddItems(delegate: AddItemViewControllerDelegate, selectedItem: ToDoItem?){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddItemViewController") { coder in
            return AddItemViewController(coder: coder, manager: ToDoDbManager(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext))
        }
        vc.delegate = delegate
        vc.selectedItem = selectedItem
        navigationController.pushViewController(vc, animated: true)

    }
    
    
    
}
