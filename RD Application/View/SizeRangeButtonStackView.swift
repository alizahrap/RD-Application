//
//  SizeRangeButtonStackView.swift
//  RD Application
//
//  Created by Георгий Кашин on 14/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class SizeRangeButtonStackView: UIStackView {

    // MARK: - Initializers
    init(withSizeRange sizeRange: [String]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        /// configure stack view
        tag = 1
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fillEqually
        spacing = 5
        
        /// create and configure buttons for every size
        for size in sizeRange {
            let button = UIButton()
            button.setTitle(size, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
            /// add button to stack view
            addArrangedSubview(button)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
