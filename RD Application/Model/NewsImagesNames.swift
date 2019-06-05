//
//  NewsImagesNames.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

enum NewsImagesNames: String, CaseIterable {
    case backpack = "backpack"
    case sportBag = "sportBag"
    case hoodie = "hoodie"
}

extension NewsImagesNames {
    static func fetchImages() -> [UIImage] {
        var arrayOfImages = [UIImage]()
        
        for imageCase in NewsImagesNames.allCases {
            let imageName = imageCase.rawValue
            guard let image = UIImage(named: imageName) else { continue }
            arrayOfImages.append(image)
        }
        return arrayOfImages
    }
}
