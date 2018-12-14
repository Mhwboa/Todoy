//
//  ViewController.swift
//  Todoy
//
//  Created by Admin on 12/14/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import UIKit

class TodoyViewController: UITableViewController {

    var itemArray = ["mmm" , "eee"  , "sss"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell

    }
    
    // tableview delegate method - check
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        

    // just for animation while clicking on the text.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //ADD New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what happen when ser clicks
            
            self.itemArray.append(textField.text!)
              self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
            print(alertTextField.text)
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        present(alert , animated: true , completion: nil)

    }
    
  
}












