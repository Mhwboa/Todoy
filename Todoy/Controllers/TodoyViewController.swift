//
//  ViewController.swift
//  Todoy
//
//  Created by Admin on 12/14/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import UIKit
import CoreData

class TodoyViewController: UITableViewController  {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
      //  context.delete(itemArray[indexPath.row])
       // itemArray.remove(at: indexPath.row)
        
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
    
   //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what happen when ser clicks
            
            
          let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
    
    //MARK: - Save items method
    
    func saveItems(){
       
        do{
            
           try  context.save()
        } catch {
            print("error")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()  , predicate : NSPredicate? = nil){

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate , addtionalPredicate])
        } else{
            request.predicate = categoryPredicate
        }
        
        
      //  let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("error")
        }

    }
    
   
  
}

//MARK: - Search Bar methods

extension TodoyViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request :NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        loadItems(with: request, predicate: predicate )
        
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print("error")
//        }

  //      tableView.reloadData()

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










