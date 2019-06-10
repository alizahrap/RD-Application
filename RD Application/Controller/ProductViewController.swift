//
//  ProductViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 10/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit
import RealmSwift

class ProductViewController: UIViewController {
    
    // MARK: - Stored Properties
    let realm = try! Realm()
    var productList: Results<Product>!
    var filteredProductList: [Product]!
    let cellManager = CellManager()
    /// current category
    var category: String!
    
    // MARK: - IB Outlets
    @IBOutlet weak var productCollection: UICollectionView!
}

// MARK: - IB Actions
extension ProductViewController {
    @IBAction func sortingButtonPressed() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Готово", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        // TODO: - Implement Sorting
        let sortingPicker = UIPickerView(frame: <#T##CGRect#>)
    }
}

// MARK: - UIViewController Methods
extension ProductViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCollection.dataSource = self
        productList = realm.objects(Product.self)
        /// create filtered product list with current category
        filteredProductList = productList.filter({ [unowned self] (product) -> Bool in
            return product.category == self.category
        })
    }
}

// MARK: - UICollectionView Data Source
extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = filteredProductList[indexPath.row]
        
        cellManager.configure(cell, with: product)
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension ProductViewController: UICollectionViewDelegate {
    
}
