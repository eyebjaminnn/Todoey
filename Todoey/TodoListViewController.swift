//
//  ViewController.swift
//  Todoey
//
//  Created by Ben on 11/2/18.
//  Copyright © 2018 Ben Pileggi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    @IBOutlet var messageTableView: UITableView!
    
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
    }

    //MARK = Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // Print array items to tableview for testing purposes
        cell.textLabel?.text = itemArray[indexPath.row]
    
        return cell
    }
    
  
    
    //MARK - TablView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Test #1 - Print row number
//        print(indexPath.row)
        // Test #2 - Print row contents
//        print(itemArray[indexPath.row])
  
        
        // Toggle checkbox on click
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        // Change gray color on 'touch/click' to fade away quickly
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    

}


