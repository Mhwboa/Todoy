//
//  CategoryTableViewController.swift
//  Todoy
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadICategory()
    
    }
     //MARK: - tableview data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
 
    
    //MAKE: - sTableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoyViewController
    
        if  let indexPath = tableView.indexPathForSelectedRow{
        
       destinationVC.selectedCategory = categories[indexPath.row ]
        }
    }
    
   
    //MARK: - SAVE CATEGORIES
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch{
            print("error")
        }
        tableView.reloadData()
    }
    
    //MARK: - load categoreis method
    func loadICategory(with request : NSFetchRequest<Category> = Category.fetchRequest() ){
        
        //  let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            categories = try context.fetch(request)
        }catch{
            print("error")
        }
        tableView.reloadData()
    }

    
    //MARK: - Add new category
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let  newCategory = Category(context: self.context)
            newCategory.name = textfield.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add a new category"
            
        }
        
        present(alert, animated: true , completion: nil)
    }
    
    
    //MARK: - TaBLE VIEW DELEGATE METHOD
}
