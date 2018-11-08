//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ben on 11/3/18.
//  Copyright © 2018 Ben Pileggi. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadCategories()
        
        tableView.separatorStyle = .none

    }

    //MARK: - TableView Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // '??' = nil coalescing operator
        // meaning: categories could be nil, if nil, return 1 row
        return categories?.count ?? 1
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.tableCellColor) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        
        
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
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    //save data & load data
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {

        categories = realm.objects(Category.self)

        tableView.reloadData()
    }

    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error saving done status, \(error)")
            }
            
        }

    }
    
    
    
     //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
           
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.tableCellColor = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Category"
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    

    
}

