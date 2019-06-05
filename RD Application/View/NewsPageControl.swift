//
//  NewsPageControl.swift
//  RD Application
//
//  Created by Георгий Кашин on 05/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class NewsPageControl: UIPageControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.numberOfPages = NewsImagesNames.allCases.count
        self.hidesForSinglePage = true
        translatesAutoresizingMaskIntoConstraints = false
        self.isEnabled = false
    }

//    func configurePageControl() {
//        self.numberOfPages = NewsImagesNames.allCases.count
//        self.hidesForSinglePage = true
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
