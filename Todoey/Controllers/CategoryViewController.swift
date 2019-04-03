//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Junaid on 30/03/19.
//  Copyright © 2019 Junaid. All rights reserved.
//

import UIKit
import RealmSwift



class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategoryData()
       
    }

    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Table load method")
        
        let category = categories?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = category?.name ?? "No Category is Added Yet"
        
        return cell
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVc = segue.destination as! TodoeyListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVc.selectedCategory = categories?[indexPath.row]
            
        }
        
    }
    
    
    //Mark: - Add Category

   
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField  = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            print("action crated")
            
            if textField.text != ""{
                
                let newCategory = Category()
                newCategory.name = textField.text!
                self.saveCategoryData(category: newCategory)
                
                
                
            }
            else{
                
                let alert = UIAlertController(title: "Insert Category", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                alert.dismiss(animated: true, completion: nil)
                
            }
           
            
        }
        
        alert.addTextField { (categoryTextField) in
            
            categoryTextField.placeholder = "Create a new Category"
            
            textField = categoryTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //Mark: - Data Manipulation Methods
    
    func saveCategoryData(category: Category){
        
        do{
            
           try realm.write {
            
                realm.add(category)
            }
        
        }catch{
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategoryData(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
}
