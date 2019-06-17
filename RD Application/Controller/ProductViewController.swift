//
//  ProductViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 10/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    // MARK: - Stored Properties
    var productList = [Product]()
    let cellManager = CellManager()
    /// current category
    var category: String!
    /// alerts
    var sortingAlert = UIAlertController()
    var sizeSelectionAlert = SizeSelectionAlert()
    
    // MARK: - IB Outlets
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var sortingButton: UIButton!
}

// MARK: - IB Actions
extension ProductViewController {
    @IBAction func sortingButtonPressed() {
        present(sortingAlert, animated: true)
    }
    
    @IBAction func toCartButtonPressed(_ sender: UIButton) {
        /// configure alert with selected product size range
        let sizeRange = Array(productList[sender.tag].sizeRange)
        sizeSelectionAlert.configure(withSizeRange: sizeRange)
        /// present alert
        present(sizeSelectionAlert.alert, animated: true)
    }
}

// MARK: - UIViewController Methods
extension ProductViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// load products from Realm to product list
        StorageManager.loadData(to: &productList, with: category)
        /// setup user interface
        setupUI()
    }
}

// MARK: - UI
extension ProductViewController {
    /// setup user interface
    func setupUI() {
        productCollection.dataSource = self
        /// setup alert
        sortingAlert = setupSortingAlert()
        /// hide navigation back button title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// Setup sorting alert with picker view
    ///
    /// - Returns: alert with picker view
    func setupSortingAlert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let sortingPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: alert.view.frame.size.width - 15, height: 150))
        sortingPicker.dataSource = self
        sortingPicker.delegate = self
        
        let doneAction = UIAlertAction(title: "Готово", style: .cancel) { [unowned self] _ in
            let selectedRow = sortingPicker.selectedRow(inComponent: 0)
            /// set title for sorting button
            let title = SortingVariations.allCases[selectedRow].rawValue
            self.sortingButton.setTitle(title, for: .normal)
            /// reload collection view
            self.productCollection.reloadData()
        }
        alert.addAction(doneAction)
        alert.view.addSubview(sortingPicker)
        /// add height constraint for alert
        alert.view.heightAnchor.constraint(equalToConstant: sortingPicker.frame.size.height + 55).isActive = true
        
        return alert
    }
}

// MARK: - Navigation
extension ProductViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetail" else { return }
        guard let destination = segue.destination as? ProductDetailViewController else { return }
        guard let indexPath = productCollection.indexPathsForSelectedItems?.first else { return }
        /// pass data to ProductDetailViewController
        destination.product = productList[indexPath.row]
    }
}

// MARK: - UICollectionView Data Source
extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = productList[indexPath.row]
        /// configure cell with product
        cellManager.configure(cell, with: product, at: indexPath)
        return cell
    }
}

// MARK: - UIPickerView Data Source
extension ProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SortingVariations.allCases.count
    }
}

// MARK: - UIPickerView Delegate
extension ProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SortingVariations.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        /// sort according to the selected row
        switch row {
        case 0:
            productList = productList.sorted { $0.date > $1.date }
        case 1:
            productList = productList.sorted { $0.price.number < $1.price.number }
        case 2:
            productList = productList.sorted { $0.price.number > $1.price.number }
        default:
            break
        }
    }
}
