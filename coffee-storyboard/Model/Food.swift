//
//  Order.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 2/1/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import Foundation
import UIKit

struct Food {
    var image: UIImage
    var name: String
    var size: String
    var price: Int64
    var description: String
    
    init(image: UIImage, name: String, size: String, price: Int64, description: String) {
        self.image = image
        self.name = name
        self.size = size
        self.price = price
        self.description = description
    }
    
}





