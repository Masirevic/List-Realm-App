//
//  ViewController.swift
//  List
//
//  Created by Ljubomir Masirevic on 2/8/19.
//  Copyright © 2019 Ljubomir Masirevic. All rights reserved.
//

import UIKit
import RealmSwift


class ToDoListVC: SwipeTableVC {

    let realm = try! Realm()
    
    var todoItems: Results<Item>?
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
      // loadItems()
        
       

     
    }
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        
        return cell
        
    }
    

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error checked state")
            }
        }

            tableView.reloadData()
        
            tableView.deselectRow(at: indexPath, animated: true)
        
        }
    
    
        
        
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                }
                } catch {
                    print("Error saving item")
                }
                
            }
            
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
    
        present(alert, animated: true, completion: nil)
        
        
        
       }
    
//    func saveItems () {
//
//        do {
//            try context.save()
//        } catch {
//         print("Error Saving \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
//
//

    func loadItems () {

       todoItems  = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
    override func updateModel(at indexPatx: IndexPath) {
        if let item = todoItems?[indexPatx.row] {
            do {
            try realm.write {
                realm.delete(item)
            }
            } catch {
                print("Error deliting Item \(error)")
            }
        }
    }
    
}


