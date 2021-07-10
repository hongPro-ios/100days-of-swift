//
//  ViewController.swift
//  Project-ShoppingList
//
//  Created by JEONGSEOB HONG on 2021/07/10.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        setupUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    func setupUI() {
        setupNavigationBar()
        setupToolbar()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refreshShoppingList))
    }
    
    func setupToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let shareButton = UIBarButtonItem(barButtonSystemItem: .reply,
                        target: self,
                        action: #selector(shareShoppingList))
        toolbarItems = [flexibleSpace, shareButton]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func shareShoppingList() {
        let stringShoppingList = shoppingList.joined(separator: "\n")
        
        let activityViewController = UIActivityViewController(activityItems: [stringShoppingList],
                                                              applicationActivities: nil)
        
        present(activityViewController, animated: true)
        
    }
    
    @objc func addItem() {
        let alertController = UIAlertController(title: "Add Item",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController]action in
            guard let item = alertController?.textFields?[0].text else { return }

            self?.shoppingList.insert(item, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func refreshShoppingList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }

}

