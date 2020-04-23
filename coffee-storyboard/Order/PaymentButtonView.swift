//
//  PaymentButtonView.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 4/23/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class PaymentButtonView: UIView {

    override func draw(_ rect: CGRect) {
        let circle = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        circle.fill()
        UIColor.black.setStroke()
        circle.stroke()
//        let shadowPath = circle
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
//        self.layer.shadowPath = shadowPath.cgPath
    }

}
