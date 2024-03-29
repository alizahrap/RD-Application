//
//  CollectionExtension.swift
//  RD Application
//
//  Created by Георгий Кашин on 17/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
