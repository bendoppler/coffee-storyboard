//
//  MemberBenefitViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 12/13/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

class MemberBenefitViewController: UIViewController {

    
    @IBOutlet weak var memberDetailInfoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        memberDetailInfoView.layer.masksToBounds = true
        memberDetailInfoView.layer.cornerRadius = 6
        memberDetailInfoView.layer.borderWidth = 1
        memberDetailInfoView.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        memberDetailInfoView.roundCorners([.topRight, .bottomRight, .topLeft, .bottomLeft], radius: 5.0, color: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0))
    }
    

}
