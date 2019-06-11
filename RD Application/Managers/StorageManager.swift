//
//  StorageManager.swift
//  RD Application
//
//  Created by Георгий Кашин on 11/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    /// Load data from Realm to product list with category
    ///
    /// - Parameters:
    ///   - productList: list of the products
    ///   - category: category of the products
    static func loadData(to productList: inout [Product], with category: String) {
        /// create filtered product list with current category
        productList = realm.objects(Product.self).filter({ (product) -> Bool in
            return product.category == category
        })
    }
}
