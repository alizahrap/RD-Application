//
//  Product.swift
//  RD Application
//
//  Created by Георгий Кашин on 10/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import RealmSwift

@objcMembers
class Product: Object {
    dynamic var name = String()
    dynamic var specification = String()
    dynamic var price = Int()
    dynamic var imageData = List<Data>()
    dynamic var category = String()
    dynamic var composition = String()
    dynamic var sizeRange = List<String>()
    dynamic var date = Date()
}
