//
//  AddItemViewController.swift
//  ToDo-CoreData2
//
//  Created by Umair on 24/05/2025.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject{
    func itemCreated()
}

class AddItemViewController: UIViewController {

    @IBOutlet weak var valueSwitch: UISwitch!
    @IBOutlet weak var txtName: UITextField!
    
    weak var delegate : AddItemViewControllerDelegate?
    var manager: ToDoDbManager
    var selectedItem: ToDoItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let item = selectedItem{
            txtName.text = item.name
            valueSwitch.isOn = item.completed
        }
    }
    
    required init?(coder: NSCoder, manager: ToDoDbManager) {
        self.manager = manager
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) needs to be implemented")
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        if let name = txtName.text, !name.isEmpty{
            
            if let existingItem = selectedItem{
                manager.update(item: existingItem, name: name, completed: valueSwitch.isOn)
            }else{
                manager.create(name: name, completed: valueSwitch.isOn)
            }
            delegate?.itemCreated()
            navigationController?.popViewController(animated: true)

        }
    }
    
}
