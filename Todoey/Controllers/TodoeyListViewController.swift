//
//  ViewController.swift
//  Todoey
//
//  Created by Junaid on 26/03/19.
//  Copyright © 2019 Junaid. All rights reserved.
//

import UIKit

class TodoeyListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Junaid"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Zubair"
        itemArray.append(newItem2)
        
        
        
        let newItem3 = Item()
        newItem3.title = "Faisal"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
        
        
       
    }
    
    //Mark - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
      
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    //MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
     
        tableView.reloadData()
     
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - ADD NEW ITEMS
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
      
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // WHAT WILL HAPPEN ONCE USER CLICKS A ADD ITEM BUTTON
            if textField.text != ""{
                
                let newItem = Item()
                newItem.title = textField.text!
            
                self.itemArray.append(newItem)
                
                self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
            
            else{
                let alert = UIAlertController(title: "insert item", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                alert.dismiss(animated: true, completion: nil)
            }
            
            
           
                
        }
        
       
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create a new item"
            
            textField = alertTextField
            
        }
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
}

