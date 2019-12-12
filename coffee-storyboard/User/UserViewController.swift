//
//  UserViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/28/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        profileImageLeadingSpacing.constant = height * 25/896
        profileInfoTopSpacing.constant = height * 81/896
        profileImageLeadingSpacing.constant = height * 8/896
        userNameLabel.font = userNameLabel.font.withSize(height*16/896)
        phoneNumberLabel.font = phoneNumberLabel.font.withSize(height*12/896)
        editProfileLabel.font = editProfileLabel.font.withSize(height*12/896)
        memberTypeLabel.font = memberTypeLabel.font.withSize(height*16/896)
        memberPointLabel.font = memberPointLabel.font.withSize(height*16/896)
        memberInfoLeadingSpacing.constant = height * 20/896
    }
    
    //MARK: Table view
    @IBOutlet weak var userTableView: UITableView! {
        didSet {
            userTableView.delegate = self
            userTableView.dataSource = self
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Thông tin tài khoản"
        case 1:
            return "Quản lý thông báo"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView, let text = header.textLabel?.text {
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: self.view.bounds.height*16/896)!]
            let boldString = NSMutableAttributedString(string: text, attributes: attributes)
            header.textLabel?.attributedText = boldString
        }
    }
    private let infos = [(UIImage(named: "location_icon"), "Quản lý địa chỉ nhận hàng"), (UIImage(named: "location_icon"), "Quản lý địa chỉ nhận hàng"), (UIImage(named: "location_icon"), "Quản lý địa chỉ nhận hàng")]
    private let notificationString = "Nhận thông báo từ chúng tôi"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return infos.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)
            if let notificationCell = cell as? NotificationTableViewCell {
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: self.view.bounds.height*16/896)!]
                notificationCell.notificationLabel.attributedText = NSAttributedString(string: notificationString, attributes: attributes)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInfoCell", for: indexPath)
            if let accountInfoCell = cell as? AccountInfoTableViewCell {
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: self.view.bounds.height*16/896)!]
                accountInfoCell.infoLabel.attributedText = NSAttributedString(string: infos[indexPath.item].1, attributes: attributes)
                accountInfoCell.iconImageView.image = infos[indexPath.item].0
            }
            return cell
        }
    }
}


