//
//  ProductCollectionViewCell.swift
//  RD Application
//
//  Created by Георгий Кашин on 10/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var toCartButton: UIButton!
}
