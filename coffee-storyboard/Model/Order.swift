//
//  Order.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 2/7/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import Foundation

struct Order {
    var foods: [Food]
    
    init(foods: [Food]? = nil) {
        self.foods = foods ?? []
    }
    
    var totalPrice: Int64 {
        get {
            var price: Int64 = 0
            foods.forEach {
                price += $0.price
            }
            return price
        }
    }
}
