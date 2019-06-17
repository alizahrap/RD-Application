//
//  ProductDetailViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 13/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - Stored Properties
    let productImageCollectionView = CarouselCollectionView(useTimer: false)
    var product = Product()
    let sizeSelectionAlert = SizeSelectionAlert()
    lazy var imagePageControl = ImagePageControl(numberOfPages: product.imageData.count)
    lazy var sizeRangeButtonStackView = SizeRangeButtonStackView(withSizeRange: Array(product.sizeRange))
    
    // MARK: - IB Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var toCartButton: UIButton!
    @IBOutlet weak var sizeTableLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
}

// MARK: - IB Actions
extension ProductDetailViewController {
    @IBAction func segmentedControlSwitched() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            descriptionLabel.isHidden = false
            compositionLabel.isHidden = true
        case 1:
            descriptionLabel.isHidden = true
            compositionLabel.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func toCartButtonPressed() {
        present(sizeSelectionAlert.alert, animated: true)
    }
}

// MARK: - UIViewController Methods
extension ProductDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
        /// pass images and page control to CarouselCollectionView class
        passData()
    }
}

// MARK: - Setup UI
extension ProductDetailViewController {
    /// setup user interface
    func setupUI() {
        /// add views to content view
        addViews()
        /// constrain views
        constrainViews()
        /// customize interface elements
        customizeInterfaceElements()

        /// configure size selection alert with size range
        sizeSelectionAlert.configure(withSizeRange: Array(product.sizeRange))
    }
    
    /// add views to content view
    func addViews() {
        /// add collection view
        contentView.addSubview(productImageCollectionView)
        /// add page control
        contentView.addSubview(imagePageControl)
        /// add size range button stack view
        contentView.addSubview(sizeRangeButtonStackView)
    }
    
    /// constrain views
    func constrainViews() {
        NSLayoutConstraint.activate([
            /// constrain collection view
            productImageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            productImageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            productImageCollectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            productImageCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.5),
            /// constrain page control
            imagePageControl.bottomAnchor.constraint(equalTo: productImageCollectionView.bottomAnchor),
            imagePageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            /// constrain size range button stack view
            sizeRangeButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sizeRangeButtonStackView.topAnchor.constraint(equalTo: productImageCollectionView.bottomAnchor, constant: 30),
            /// constrain segmented control
            segmentedControl.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            /// constrain labels
            priceLabel.topAnchor.constraint(equalTo: sizeRangeButtonStackView.bottomAnchor, constant: 20),
            sizeTableLabel.bottomAnchor.constraint(equalTo: sizeRangeButtonStackView.topAnchor, constant: -5)
        ])
    }
    
    /// customize interface elements
    func customizeInterfaceElements() {
        title = product.name
        priceLabel.text = String(product.price.number) + product.price.symbol
        descriptionLabel.text = product.specification
        compositionLabel.text = product.composition
        toCartButton.layer.cornerRadius = 8
        /// configure collection view
        productImageCollectionView.isScrollEnabled = true
        productImageCollectionView.layer.cornerRadius = 5
    }
}

// MARK: - Pass Data
extension ProductDetailViewController {
    /// pass data to CarouselCollectionView class
    func passData() {
        /// create array of images using product image data
        var productImages = [UIImage]()
        for imageData in product.imageData {
            guard let image = UIImage(data: imageData) else { continue }
            productImages.append(image)
        }
        productImageCollectionView.setProperties(images: productImages, pageControl: imagePageControl)
    }
}
