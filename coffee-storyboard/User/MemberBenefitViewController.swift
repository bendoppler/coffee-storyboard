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
    @IBOutlet weak var memberBenefitView: UIView!
    @IBOutlet weak var diamondMemberInfoView: MemberBenefitInfoItemView!
    @IBOutlet weak var goldMemberInfoView: MemberBenefitInfoItemView!
    @IBOutlet weak var silverMemberInfoView: MemberBenefitInfoItemView!
    @IBOutlet weak var bronzeMemberInfoView: MemberBenefitInfoItemView!
    @IBOutlet weak var memberTitleLabel: UILabel!
    
    let titles = ["Thành viên hoàng kim", "Thành viên vàng", "Thành viên bạc", "Thành viên đồng"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memberDetailInfoView.layer.masksToBounds = true
        memberDetailInfoView.layer.cornerRadius = 6
        memberDetailInfoView.layer.borderWidth = 1
        memberDetailInfoView.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        memberDetailInfoView.roundCorners([.topRight, .bottomRight, .topLeft, .bottomLeft], radius: 5.0, color: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0))
        memberBenefitView.roundCorners([.topRight, .bottomRight, .topLeft, .bottomLeft], radius: 8.0, color: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0))
        memberBenefitView.drawShadow(opacity: 0.6, color: UIColor.lightGray.cgColor)
    }
    
    
    @IBAction func showDiamondMemberInfo(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            diamondMemberInfoView.backgroundColor = UIColor.white
            goldMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            silverMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            bronzeMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: 16)!]
            memberTitleLabel.attributedText = NSAttributedString(string: titles[0], attributes: attributes)
        }
    }
    @IBAction func showGoldMemberInfo(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            goldMemberInfoView.backgroundColor = UIColor.white
            diamondMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            silverMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            bronzeMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: 16)!]
            memberTitleLabel.attributedText = NSAttributedString(string: titles[1], attributes: attributes)
        }
    }
    
    @IBAction func showSilverMemberInfo(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            silverMemberInfoView.backgroundColor = UIColor.white
            diamondMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            goldMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            bronzeMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: 16)!]
            memberTitleLabel.attributedText = NSAttributedString(string: titles[2], attributes: attributes)
        }
    }
    @IBAction func showBronzeMemberInfo(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            bronzeMemberInfoView.backgroundColor = UIColor.white
            diamondMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            goldMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            silverMemberInfoView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: 16)!]
            memberTitleLabel.attributedText = NSAttributedString(string: titles[3], attributes: attributes)
        }
    }
}
