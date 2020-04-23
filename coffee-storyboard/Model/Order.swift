//
//  Order.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 2/7/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import Foundation

struct Order {
    var foods: [OrderFood]
    
    init(foods: [OrderFood]? = nil) {
        self.foods = foods ?? []
    }
    
    var totalPrice: Int64 {
        get {
            var price: Int64 = 0
            foods.forEach {
                price += $0.food.price
            }
            return price
        }
    }
}

struct OrderFood {
    var food: Food
    var cnt: Int
    init(food: Food, cnt: Int = 1) {
        self.food = food
        self.cnt = cnt
    }
}
