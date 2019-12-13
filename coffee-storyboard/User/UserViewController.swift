//
//  UserViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/28/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class UserViewController: UIViewController {
    
    //MARK: Layout subviews in multiple screen sizes
    @IBOutlet weak var editProfileLabel: UILabel!
    @IBOutlet weak var memberPointView: UIView!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var profileImageTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var profileImageLeadingSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var profileInfoTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var profileInfoLeadingSpacing: NSLayoutConstraint!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var memberTypeLabel: UILabel!
    @IBOutlet weak var memberPointLabel: UILabel!
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    @IBOutlet weak var memberInfoLeadingSpacing: NSLayoutConstraint!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var accountInfoView: UIView!
    @IBOutlet weak var notificationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = self.view.bounds.height
        editProfileLabel.layer.masksToBounds = true
        editProfileLabel.layer.cornerRadius = 6
        editProfileLabel.layer.borderWidth = 1
        editProfileLabel.layer.borderColor = UIColor(red: 1, green: 199/255, blue: 0, alpha: 1.0).cgColor
        memberPointView.layer.masksToBounds = true
        memberPointView.layer.borderWidth = 1
        memberPointView.roundCorners([.topLeft, .bottomLeft], radius: 5.0, color: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0))
        memberPointView.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        nextButtonView.layer.masksToBounds = true
        nextButtonView.layer.borderWidth = 1
        nextButtonView.roundCorners([.topRight, .bottomRight], radius: 5.0, color: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0))
        nextButtonView.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        profileImageTopSpacing.constant = height * 69/896
        profileImageLeadingSpacing.constant = height * 50/896
        profileInfoTopSpacing.constant = height * 81/896
        profileImageLeadingSpacing.constant = height * 50/896
        userNameLabel.font = userNameLabel.font.withSize(height*16/896)
        phoneNumberLabel.font = phoneNumberLabel.font.withSize(height*12/896)
        editProfileLabel.font = editProfileLabel.font.withSize(height*12/896)
        memberTypeLabel.font = memberTypeLabel.font.withSize(height*16/896)
        memberPointLabel.font = memberPointLabel.font.withSize(height*16/896)
        memberInfoLeadingSpacing.constant = height * 20/896
        notificationSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        accountInfoView.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: 5.0, color: UIColor.white)
        notificationView.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: 5.0, color: UIColor.white)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var shadowPath = UIBezierPath(rect: accountInfoView.bounds)
        accountInfoView.layer.masksToBounds = false
        accountInfoView.layer.shadowColor = UIColor.lightGray.cgColor
        accountInfoView.layer.shadowOpacity = 0.4
        accountInfoView.layer.shadowPath = shadowPath.cgPath
        shadowPath = UIBezierPath(rect: notificationView.bounds)
        notificationView.layer.masksToBounds = false
        notificationView.layer.shadowColor = UIColor.lightGray.cgColor
        notificationView.layer.shadowOpacity = 0.4
        notificationView.layer.shadowPath = shadowPath.cgPath
    }
}


