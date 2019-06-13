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
    
    @IBAction func toCartButtonPressed(_ sender: UIButton) {
        /// setup alert with selected product size range
        let sizeRange = Array(productList[sender.tag].sizeRange)
        setupSelectSizeAlert(with: sizeRange)
        /// present alert
        present(selectSizeAlert, animated: true)
    }
}

// MARK: - UIViewController Methods
extension ProductViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
    }
}

// MARK: - UI
extension ProductViewController {
    /// setup user interface
    func setupUI() {
        productCollection.dataSource = self
        /// load products from Realm to product list
        StorageManager.loadData(to: &productList, with: category)
        
        /// setup alerts
        sortingAlert = setupSortingAlert()
        selectSizeAlert = createSelectSizeAlert()
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
    
    /// Create alert for size selection
    ///
    /// - Returns: select size alert
    func createSelectSizeAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Выберите размер", message: "\n\n", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let doneAction = UIAlertAction(title: "Готово", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        
        return alert
    }
    
    /// Setup alert for size selection with product sizes
    ///
    /// - Parameter sizeRange: size range of selected product
    func setupSelectSizeAlert(with sizeRange: [String]) {
        /// setup stack view for size buttons
        let sizeStackView = UIStackView()
        configure(sizeStackView)
        /// remove stack view from alert if already exists
        let oldStackView = selectSizeAlert.view.viewWithTag(sizeStackView.tag)
        oldStackView?.removeFromSuperview()
        
        /// create and configure button for every size and add it to size stack view
        for size in sizeRange {
            let button = UIButton()
            configure(button, with: size)
            sizeStackView.addArrangedSubview(button)
        }
        /// add size stack view to alert and constrain it
        selectSizeAlert.view.addSubview(sizeStackView)
        sizeStackView.centerXAnchor.constraint(equalTo: selectSizeAlert.view.centerXAnchor).isActive = true
        sizeStackView.centerYAnchor.constraint(equalTo: selectSizeAlert.view.centerYAnchor, constant: -5).isActive = true
    }
    
    /// Configure stack view
    ///
    /// - Parameter stackView: size stack view
    func configure(_ stackView: UIStackView) {
        stackView.tag = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
    }
    
    /// Configure button
    ///
    /// - Parameters:
    ///   - button: size button
    ///   - size: size 
    func configure(_ button: UIButton, with size: String) {
        button.setTitle(size, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
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
            productList = productList.sorted { $0.price < $1.price }
        case 2:
            productList = productList.sorted { $0.price > $1.price }
        default:
            break
        }
    }
}
