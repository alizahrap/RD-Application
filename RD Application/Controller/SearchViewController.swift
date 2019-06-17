//
//  SearchViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 17/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    // MARK: - Stored Properties
    var cellManager = CellManager()
    var sizeSelectionAlert = SizeSelectionAlert()
    var productList = [Product]()
    var filteredProductList = [Product]()
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Computed Properties
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    /// property indicating whether content is filtered
    var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - IB Outlets
    @IBOutlet weak var productCollection: UICollectionView!
}

// MARK: - IB Actions
extension SearchViewController {
    @IBAction func toCartButtonPressed(_ sender: UIButton) {
        /// configure alert with selected product size range
        let sizeRange = Array(productList[sender.tag].sizeRange)
        sizeSelectionAlert.configure(withSizeRange: sizeRange)
        /// present alert
        present(sizeSelectionAlert.alert, animated: true)
    }
}

// MARK: - UIViewController Methods
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// load products from Realm to product list
        StorageManager.loadData(to: &productList)
        /// setup user interface
        setupUI()
    }
}

// MARK: - UI
extension SearchViewController {
    /// setup user interface
    func setupUI() {
        /// setup search controller
        setupSearchController()
    }
}

// MARK: - Setup SearchController
extension SearchViewController {
    /// setup search controller
    func setupSearchController() {
        /// search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Что бы Вы хотели..?"
        searchController.searchBar.setValue("Отмена", forKey: "_cancelButtonText")
        searchController.searchBar.tintColor = .black
        /// navigation item
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        //definesPresentationContext = true
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentBySearchText(searchController.searchBar.text!)
    }
    /// Filter content by text in the search bar
    ///
    /// - Parameter searchText: search bar text
    func filterContentBySearchText(_ searchText: String) {
        filteredProductList = productList.filter({ (product) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased())
        })
        productCollection.reloadData()
    }
}

// MARK: - UICollectionView Data Source
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredProductList.count : productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = isFiltered ? filteredProductList[indexPath.row] : productList[indexPath.row]
        /// configure cell with product
        cellManager.configure(cell, with: product, at: indexPath)
        return cell
    }
}

// MARK: - Navigation
extension SearchViewController {
    
    
    // TODO: - Implement navigation from here to detail view controller
    
    
}
