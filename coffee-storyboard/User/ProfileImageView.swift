//
//  ProfileImageView.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 12/11/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

@IBDesignable
class ProfileImageView: UIView {

    override func draw(_ rect: CGRect) {
        let boundingRect = CGRect(x: rect.height * 5/100, y: rect.height * 5/100, width: rect.height * 90/100, height: rect.height * 90/100)
        let circle = UIBezierPath(ovalIn: boundingRect)
        UIColor.white.setFill()
        UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 231/255).setStroke()
        circle.lineWidth = rect.height * 10/100
        circle.stroke()
        circle.fill()
    }

}
