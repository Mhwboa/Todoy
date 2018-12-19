//
//  CategoryTableViewController.swift
//  Todoy
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadICategories()
    
    }
     //MARK: - tableview data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet "
        
        return cell
    }
 
    
    //MAKE: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoyViewController
    
        if  let indexPath = tableView.indexPathForSelectedRow{
        
       destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
   
    //MARK: - SAVE CATEGORIES
    
    func save(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch{
            print("error")
        }
        tableView.reloadData()
    }
    
    //MARK: - load categoreis method
    func loadICategories(){
        
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }

    
    //MARK: - Add new category
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let  newCategory = Category()
            newCategory.name = textfield.text!
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add a new category"
            
        }
        
        present(alert, animated: true , completion: nil)
    }
}
