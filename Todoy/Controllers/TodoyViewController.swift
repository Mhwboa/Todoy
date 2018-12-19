//
//  ViewController.swift
//  Todoy
//
//  Created by Admin on 12/14/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import UIKit
import RealmSwift

class TodoyViewController: UITableViewController  {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
              loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
     ///searchBar.delegate = self
     
    
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      ///  let cell = UITableViewCell(style: .default, reuseIdentifier: "todoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]
        {
            cell.textLabel?.text = item.title
                
                // ternary operator =  -> value = condition ? value if true : value if false
                
                cell.accessoryType = item.done ?  .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
 
        return cell

    }
    
    // tableview delegate method - check
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                item.done = !item.done
                   // for delete -> realm.delete(item)
            }
            }catch{
                print("error")
            }
        }
        
        tableView.reloadData()
        
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
   //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what happen when per clicks
        
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch{
                    print("error")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
       present(alert , animated: true , completion: nil)

    }
    
    
    
    func loadItems(){
        
      todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
          tableView.reloadData()
    }

   
  
}

//MARK: - Search Bar methods

extension TodoyViewController : UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    
    
    }
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
             searchBar.resignFirstResponder()
            }

        }
    }
}










