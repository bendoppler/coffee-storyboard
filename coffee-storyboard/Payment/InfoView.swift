//
//  InfoView.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 4/29/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class InfoView: UIView {

    override func draw(_ rect: CGRect) {
        let rectangle = UIBezierPath(rect: rect)
        UIColor.white.setFill()
        rectangle.fill()
        let shadowPath = rectangle
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowPath = shadowPath.cgPath
    }

}
