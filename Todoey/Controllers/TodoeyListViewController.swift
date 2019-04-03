//
//  ViewController.swift
//  Todoey
//
//  Created by Junaid on 26/03/19.
//  Copyright © 2019 Junaid. All rights reserved.
//

import UIKit
import RealmSwift
class TodoeyListViewController: UITableViewController {

    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
   
    
   
    
   
    override func viewDidLoad() {
        
      super.viewDidLoad()
      
        
        
        
       
    }
    
    //Mark - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        }
        else{
            cell.textLabel?.text = "No Item is Added yet"
        }
        
       
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    //MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = todoItems?[indexPath.row]{
            
            do{
                
                try realm.write {
                    
                    item.done = !item.done
                }
                
            }catch{
                print("Error saving Done Status \(error)")
            }
            
        }
        
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
                
                if let currentCategory = self.selectedCategory{
                    do{
                        try self.realm.write {
                            
                            let newItem = Item()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date.init()
                            currentCategory.items.append(newItem)
                        }
                    }catch{
                        
                        print("Erroe Saving new Items \(error)")
                    }
                   
                    
                    
                }
                
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
    
    //MARK: - DATA MANIPULATON METHODS
    
   
    
    func loadItems(){
    
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
       
        tableView.reloadData()
    
    }

}

//MARK: - SEARCH BAR METHODS

extension TodoeyListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@",  searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        
        tableView.reloadData()
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0{
            
            loadItems()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
            
            
        }
        
    }
    
}
