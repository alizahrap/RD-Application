//
//  CellManager.swift
//  RD Application
//
//  Created by Георгий Кашин on 08/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CellManager {
    /// Configure cell
    ///
    /// - Parameters:
    ///   - cell: configurable cell
    ///   - title: cell title
    ///   - image: cell image
    func configure(_ cell: CategoryTableViewCell, titled title: String, with image: UIImage) {
        cell.titleLabel.text = title
        cell.backgroundImageView.image = image
        cell.backgroundImageView.contentMode = .scaleAspectFill
        cell.backgroundImageView.layer.cornerRadius = 5
    }
    
    /// Configure cell
    ///
    /// - Parameters:
    ///   - cell: configurable cell
    ///   - product: product for cell
    func configure(_ cell: ProductCollectionViewCell, with product: Product, at indexPath: IndexPath) {
        cell.productName.text = product.name
        cell.productPrice.text = String(product.price.number) + product.price.symbol
        cell.toCartButton.tag = indexPath.row
        cell.layer.cornerRadius = 5
        guard let imageData = product.imageData.first else { return }
        cell.productImage.image = UIImage(data: imageData)
        cell.productImage.contentMode = .scaleAspectFill
    }
}
