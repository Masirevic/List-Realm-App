//
//  Item.swift
//  List
//
//  Created by Ljubomir Masirevic on 2/14/19.
//  Copyright © 2019 Ljubomir Masirevic. All rights reserved.
//

import Foundation
import RealmSwift



class Item: Object {
    @objc dynamic  var title: String = " "
     @objc dynamic var done: Bool = false
     var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}



















