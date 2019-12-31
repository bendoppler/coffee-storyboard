//
//  MemberBenefitInfoItemView.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 12/31/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

class MemberBenefitInfoItemView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let boundingRect = CGRect(x: rect.height * 1/3, y: rect.height * 1/4, width: rect.height * 1/2, height: rect.height * 1/2)
        let circle = UIBezierPath(ovalIn: boundingRect)
        UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 196/255).setFill()
        circle.fill()
    }


}
