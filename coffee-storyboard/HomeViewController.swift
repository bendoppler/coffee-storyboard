//
//  HomeViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/20/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var mainBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var couponBarView: UIView!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var couponImageView: UIImageView!
    
    @IBOutlet weak var orderBarView: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var orderImageView: UIImageView!
    
    @IBOutlet weak var bonusPointBarView: UIView!
    @IBOutlet weak var bonusPointLabel: UILabel!
    @IBOutlet weak var bonusPointImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenHeight = self.view.bounds.height
        mainBarHeight.constant = screenHeight*0.1227678751
        couponBarView.addRightBorder(with: UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0), andWidth: 1.0)
        orderBarView.addRightBorder(with: UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0), andWidth: 1.0)
        couponBarView.roundCorners([.topLeft, .bottomLeft] , radius: 5.0)
        bonusPointBarView.roundCorners([.topRight, .bottomRight], radius: 5.0)
        couponLabel.font = couponLabel.font.withSize(screenHeight * 16/896)
        orderLabel.font = orderLabel.font.withSize(screenHeight * 16/896)
        bonusPointLabel.font = bonusPointLabel.font.withSize(screenHeight * 16/896)
        couponImageView.frame.size = CGSize(width: screenHeight * 42/896, height: screenHeight * 42/896)
        orderImageView.frame.size = CGSize(width: screenHeight * 39/896, height: screenHeight * 39/896)
        bonusPointImageView.frame.size = CGSize(width: screenHeight * 39/896, height: screenHeight * 39/896)
        
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners,cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
