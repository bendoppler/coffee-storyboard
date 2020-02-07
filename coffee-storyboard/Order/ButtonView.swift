//
//  ButtonView.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 2/4/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class ButtonView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let boundingRect = CGRect(x: rect.height * 5/100, y: rect.height * 5/100, width: rect.height * 90/100, height: rect.height * 90/100)
        let circle = UIBezierPath(ovalIn: boundingRect)
        UIColor.white.setFill()
        circle.fill()
        let shadowPath = circle
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowPath = shadowPath.cgPath
    }

}
