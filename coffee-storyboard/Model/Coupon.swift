//
//  Coupon.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/29/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import Foundation
import UIKit

struct Coupon {
    var name: String
    var description: String
    var image: UIImage
    var from: Date
    var date: Date
    var fullDescription: String
    
    init(name: String, description: String, image: UIImage,from: Date, date: Date, fullDescription: String)
    {
        self.name = name
        self.description = description
        self.image = image
        self.date = date
        self.fullDescription = fullDescription
        self.from = from
    }
}

struct CouponHistory {
    var coupon: Coupon
    var usedDate: Date
    
    init(coupon: Coupon, usedDate: Date) {
        self.coupon = coupon
        self.usedDate = usedDate
    }
}
