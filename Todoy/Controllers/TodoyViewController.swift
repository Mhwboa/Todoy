//
//  ViewController.swift
//  Todoy
//
//  Created by Admin on 12/14/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import UIKit

class TodoyViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      ///  let cell = UITableViewCell(style: .default, reuseIdentifier: "todoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //will make the if statement as ternary operator
//                if itemArray[indexPath.row].done == true {
//                    cell.accessoryType = .checkmark
//                } else{
//                    cell.accessoryType = .none
//                }
        
        // ternary operator =  -> value = condition ? value if true : value if false
        
        cell.accessoryType = itemArray[indexPath.row].done  ?  .checkmark : .none
        
        return cell

    }
    
    // tableview delegate method - check
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
          saveItems()
        
//        the line above is equals to all in bottom
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else{
//            itemArray[indexPath.row].done = false
//        }
        
       
        
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        }else{
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        }

    // just for animation while clicking on the text.
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //ADD New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what happen when ser clicks
          let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
       present(alert , animated: true , completion: nil)

    }
    
    // method to save items
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data  = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("error")
            }
            
        }
        
    }
  
}












