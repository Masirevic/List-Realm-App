//
//  ToDoExtension.swift
//  List
//
//  Created by Ljubomir Masirevic on 2/9/19.
//  Copyright © 2019 Ljubomir Masirevic. All rights reserved.
//

import UIKit
import RealmSwift



extension ToDoListVC: UISearchBarDelegate  {


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems? .filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        

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










