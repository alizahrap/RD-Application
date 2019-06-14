//
//  SizeSelectionAlert.swift
//  RD Application
//
//  Created by Георгий Кашин on 14/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class SizeSelectionAlert {
    
    let alert = UIAlertController(title: "Выберите размер", message: "\n\n", preferredStyle: .alert)

    init() {
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let doneAction = UIAlertAction(title: "Готово", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
    }
    
    /// Configure alert with size range
    ///
    /// - Parameter sizeRange: array of product sizes
    func configure(withSizeRange sizeRange: [String]) {
        /// create stack view for size buttons
        let sizeStackView = SizeRangeButtonStackView(withSizeRange: sizeRange)
        /// remove old stack view from alert if exists
        let oldStackView = alert.view.viewWithTag(sizeStackView.tag)
        oldStackView?.removeFromSuperview()
        
        /// add size stack view to alert
        alert.view.addSubview(sizeStackView)
        sizeStackView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        sizeStackView.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: -5).isActive = true
    }
}
