//
//  CategoryVC.swift
//  List
//
//  Created by Ljubomir Masirevic on 2/10/19.
//  Copyright © 2019 Ljubomir Masirevic. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryVC: SwipeTableVC {
    
    
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories"
        
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            
              let newCategory = Category()
              newCategory.name = textField.text!

            self.save(category: newCategory)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category"
            textField = alertTextField
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func save (category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error Saving \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems () {
        
       categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListVC
        
        if let indexPatxxx = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPatxxx.row]
        }
        
    }
    
    override func updateModel(at indexPatx: IndexPath) {
                    if let categoryForDelition = self.categories?[indexPatx.row] {
                        do {
                            try self.realm.write {
                                self.realm.delete(categoryForDelition)
                            }
                        } catch {
                            print("Error deliting")
                        }
        
                    }
    }
    
    
    
}
