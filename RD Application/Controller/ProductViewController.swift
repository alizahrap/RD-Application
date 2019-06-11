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
    var sortingAlert = UIAlertController()
    var selectSizeAlert = UIAlertController()
    
    // MARK: - IB Outlets
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var sortingButton: UIButton!
}

// MARK: - IB Actions
extension ProductViewController {
    @IBAction func sortingButtonPressed() {
        present(sortingAlert, animated: true)
    }
    @IBAction func toCartButtonPressed() {
        let alert = UIAlertController(title: "Выберите размер", message: "\n\n\n", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let doneAction = UIAlertAction(title: "Готово", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        alert.isModalInPopover = true
        
        // TODO: - implement select size alert
        
        let firstButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        firstButton.setTitle("42", for: .normal)
        firstButton.center = alert.view.center
        let secondButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        secondButton.setTitle("44", for: .normal)
        secondButton.layer.borderWidth = 1
        secondButton.layer.cornerRadius = 5
        
        let stackView = UIStackView(frame: CGRect(x: 100, y: 100, width: 30, height: 30))
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(firstButton)
        alert.view.addSubview(firstButton)
        
        present(alert, animated: true)
    }
    
}

// MARK: - UIViewController Methods
extension ProductViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCollection.dataSource = self
        /// load products from Realm to product list
        StorageManager.loadData(to: &productList, with: category)
        /// setup sorting alert with picker view
        sortingAlert = setupSortingAlert()
    }
}

// MARK: - UI
extension ProductViewController {
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
        alert.view.addConstraint(NSLayoutConstraint(item: alert.view as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: sortingPicker.frame.size.height + 55))
        
        return alert
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
        cellManager.configure(cell, with: product)
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
            productList = productList.sorted { $0.price < $1.price }
        case 2:
            productList = productList.sorted { $0.price > $1.price }
        default:
            break
        }
    }
}
