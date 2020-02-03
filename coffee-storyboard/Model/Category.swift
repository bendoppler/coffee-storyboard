//
//  Category.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 2/1/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import Foundation
import UIKit

struct Category {
    var name: String
    var foods: [Food]
    
    init(name: String, foods: [Food]) {
        self.name = name
        self.foods = foods
    }
}







