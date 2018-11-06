//
//  Item.swift
//  Todoey
//
//  Created by Ben on 11/5/18.
//  Copyright © 2018 Ben Pileggi. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
