//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ben on 11/3/18.
//  Copyright © 2018 Ben Pileggi. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    //MARK: - TableView Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // Print array items to tableview for testing purposes
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        return cell
    }
    

    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    //save data & load data
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving category, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        
        
        do {
            categories = try context.fetch(request)
            print("Loaded Items Successfully!")
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
   
    
    
    
     //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen once user clicks Add item to our UIAlert button
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Category"
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    

    
}
