//
//  ViewController.swift
//  Todoey
//
//  Created by Junaid on 26/03/19.
//  Copyright © 2019 Junaid. All rights reserved.
//

import UIKit
import CoreData
class TodoeyListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
   
    
   
    override func viewDidLoad() {
        
       // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
       // print(dataFilePath)
        
        super.viewDidLoad()
      
        
        
        
       
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
        
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
     
     
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - ADD NEW ITEMS
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
      
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // WHAT WILL HAPPEN ONCE USER CLICKS A ADD ITEM BUTTON
            if textField.text != ""{
                
              
                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
            
                self.itemArray.append(newItem)
                
                self.saveData()
                
               
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
    
    func saveData(){
        
       
        do{
           
          try context.save()
            
        }catch{
           print("error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
    
        
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name! )
        
        if let addtionalPredicate = predicate{
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])

        }
        else{
            request.predicate = categoryPredicate
        }
        
        
       
    
    do{
       itemArray =  try context.fetch(request)
    }catch{
        print("Error fectching data from context \(error)")
    }
        tableView.reloadData()
    
    }

}

//MARK: - SEARCH BAR METHODS

extension TodoeyListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        

        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
        
        
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
