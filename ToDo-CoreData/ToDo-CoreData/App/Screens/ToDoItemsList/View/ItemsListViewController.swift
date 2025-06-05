//
//  ItemsListViewController.swift
//  ToDo-CoreData2
//
//  Created by Umair on 24/05/2025.
//

import UIKit

class ItemsListViewController: UIViewController {

    var viewModel : ItemsListViewModel
    weak var coordinator : AppCoordinator?
    
    lazy var tableView : UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUserInterface()
        updateTableData()
    }
    
    required init?(coder: NSCoder, viewModel : ItemsListViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) needs to be called")
    }
    
    func setUpUserInterface(){
        title = "To-Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(btnAddTapped))
        
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

    }
    
    @objc func btnAddTapped(){
        coordinator?.navigateToAddItems(delegate: self, selectedItem: nil)
    }
    
    func updateTableData(){
        viewModel.getAllItems()
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }

}


extension ItemsListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        let item = viewModel.items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.imageView?.image = item.completed ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        coordinator?.navigateToAddItems(delegate: self, selectedItem: item)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        if editingStyle == .delete{
            viewModel.items.remove(at: indexPath.row)
            viewModel.remove(item: item)
            //viewModel.remove(item: viewModel.items[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
}

extension ItemsListViewController: AddItemViewControllerDelegate{
    func itemCreated() {
        updateTableData()
    }
}
