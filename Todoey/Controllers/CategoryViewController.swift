//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Junaid on 30/03/19.
//  Copyright © 2019 Junaid. All rights reserved.
//

import UIKit
import CoreData



class CategoryViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategoryData()
       
    }

    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Table load method")
        
        let category = categoryArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = category.name
        
        return cell
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVc = segue.destination as! TodoeyListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVc.selectedCategory = categoryArray[indexPath.row]
        }
        
    }
    
    
    //Mark: - Add Category

   
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField  = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            print("action crated")
            
            if textField.text != ""{
                
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text
                
                self.categoryArray.append(newCategory)
                self.saveCategoryData()
                
                
                
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
    
    func saveCategoryData(){
        
        do{
            
            try context.save()
        
        }catch{
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategoryData(){
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
          categoryArray = try context.fetch(request)
        }
        catch{
            print("Error fetching context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
}
