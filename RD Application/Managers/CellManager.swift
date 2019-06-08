//
//  CellManager.swift
//  RD Application
//
//  Created by Георгий Кашин on 08/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

// TODO: - implement configuring cell
class CellManager {
    func configure(_ cell: CategoryTableViewCell, with indexPath: IndexPath) {
        cell.titleLabel.text = categoryList[indexPath.row]
        cell.backgroundImageView.image = UIImage(named: "sweatshirt")
        cell.backgroundImageView.contentMode = .scaleAspectFill
        cell.backgroundImageView.layer.cornerRadius = 5
    }
}
