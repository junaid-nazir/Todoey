//
//  Category.swift
//  Todoey
//
//  Created by Junaid on 01/04/19.
//  Copyright © 2019 Junaid. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
