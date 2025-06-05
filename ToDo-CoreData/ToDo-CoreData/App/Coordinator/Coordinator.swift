//
//  Coordinator.swift
//  ToDo-CoreData2
//
//  Created by Umair on 24/05/2025.
//

import UIKit

protocol Coordinator{
    var navigationController : UINavigationController {get set}
    var childCoordinators : [Coordinator]? {get set}
    func start()
}
