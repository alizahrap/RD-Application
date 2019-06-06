//
//  NewsImages.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

enum NewsImages: String, CaseIterable {
    case backpack = "backpack"
    case sportBag = "sportBag"
    case hoodie = "hoodie"
}

extension NewsImages {
    /// Create images with NewsImages enum names
    ///
    /// - Returns: array of news images
    static func fetchImages() -> [UIImage] {
        var arrayOfImages = [UIImage]()
        
        for imageCase in NewsImages.allCases {
            let imageName = imageCase.rawValue
            guard let image = UIImage(named: imageName) else { continue }
            arrayOfImages.append(image)
        }
        return arrayOfImages
    }
}
