//
//  NewsCollectionViewCell.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Stored Properties
    static let reuseIdentifier = "NewsCollectionViewCell"
    let newsImageView = UIImageView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        /// add news image view within cell
        addNewsImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Appearance
extension NewsCollectionViewCell {
    /// add news image view within cell
    func addNewsImageView() {
        addSubview(newsImageView)
        /// configure news image view
        newsImageView.contentMode = UIView.ContentMode.scaleAspectFill
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        /// constrain news image view within cell
        newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        newsImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
