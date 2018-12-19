//
//  Category.swift
//  Todoy
//
//  Created by Admin on 12/18/18.
//  Copyright © 2018 mhwboa. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
