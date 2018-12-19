//
//  item.swift
//  Todoy
//
//  Created by Admin on 12/18/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    }
