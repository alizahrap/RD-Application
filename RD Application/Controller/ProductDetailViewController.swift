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
    lazy var imagePageControl = ImagePageControl(numberOfPages: product.imageData.count)
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
        addCollectionView()
        addPageControl()
    }
    
    /// add collection view
    func addCollectionView() {
        /// configure collection view
        productImageCollectionView.isScrollEnabled = true
        productImageCollectionView.layer.cornerRadius = 5
        
        view.addSubview(productImageCollectionView)
        /// constrain collection view
        productImageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        productImageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        productImageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        productImageCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.5).isActive = true
    }
    
    /// add page control
    func addPageControl() {
        view.addSubview(imagePageControl)
        /// constrain page control
        imagePageControl.bottomAnchor.constraint(equalTo: productImageCollectionView.bottomAnchor).isActive = true
        imagePageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
