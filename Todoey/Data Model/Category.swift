//
//  Category.swift
//  Todoey
//
//  Created by Ben on 11/5/18.
//  Copyright © 2018 Ben Pileggi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()

    //    let array = Array<Int>()
}
