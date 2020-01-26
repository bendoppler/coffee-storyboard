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
    @IBOutlet weak var profileImageView: ProfileImageView!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var profileInfoTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var profileInfoLeadingSpacing: NSLayoutConstraint!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var memberTypeLabel: UILabel!
    @IBOutlet weak var memberPointLabel: UILabel!
    @IBOutlet weak var memberInfoLeadingSpacing: NSLayoutConstraint!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var accountInfoView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var showAddressStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        accountInfoView.drawShadow(opacity: 0.5, color: UIColor.lightGray.cgColor)
        notificationView.drawShadow(opacity: 0.5, color: UIColor.lightGray.cgColor)
        let height = self.view.bounds.height
        profileImageTopSpacing.constant = height * 69/896
        profileImageLeadingSpacing.constant = height * 50/896
        profileInfoTopSpacing.constant = height * 81/896
        profileImageLeadingSpacing.constant = height * 50/896
        editProfileLabel.setAttributedFont("Roboto", height*12/896, editProfileLabel.text ?? "Chỉnh sửa")
        memberTypeLabel.setAttributedFont("Roboto-Bold", height*16/896, memberTypeLabel.text ?? "Thành viên vàng")
        memberPointLabel.setAttributedFont("Roboto-Bold", height*16/896, memberPointLabel.text ?? "120 điểm")
        memberInfoLeadingSpacing.constant = height * 20/896
        notificationSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        accountInfoView.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: 5.0, color: UIColor.white)
        notificationView.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: 5.0, color: UIColor.white)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.showAddressScreen(_:)))
        self.showAddressStackView.addGestureRecognizer(gesture)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    //MARK: Go to other screens
    @IBAction func showMemberBenefitScreen(_ sender: UITapGestureRecognizer) {
        if sender.state == UITapGestureRecognizer.State.ended {
            performSegue(withIdentifier: "Show Benefit", sender: sender)
        }
    }
    @IBAction func showUserInfoScreen(_ sender: UITapGestureRecognizer) {
        if sender.state == UITapGestureRecognizer.State.ended {
            performSegue(withIdentifier: "Show Info", sender: sender)
        }
    }
    
    
    @IBAction func showAddressScreen(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            performSegue(withIdentifier: "Show Address", sender: sender)
        }
    }
    
    //MARK: Update UI when comeback to this screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let height = self.view.bounds.height
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.customTabBar.isHidden = false
        }
        if let image = stateController?.user.image {
            DispatchQueue.main.async { [weak self] in
                let imageView = UIImageView(image: image)
                if let frame = self?.profileImageView.bounds {
                    imageView.frame = frame
                    imageView.makeRounded(borderWidth: 5, color: UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 231/255).cgColor)
                    self?.profileImageView.addSubview(imageView)
                    self?.profileImageView.bringSubviewToFront(imageView)
                }
            }
        }
        if let phoneNumber = stateController?.user.phoneNumber, phoneNumber != "" {
            phoneNumberLabel.setAttributedFont("Roboto", height*12/896, phoneNumber)
        } else {
            phoneNumberLabel.setAttributedFont("Roboto", height*12/896, "")
        }
        let userName = stateController?.user.name
        userNameLabel.setAttributedFont("Roboto-Bold", height*16/896, userName ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Benefit" {
            if let memberBenefitVC = segue.destination as? MemberBenefitViewController {
                if let tabBarVC = tabBarController as? TabBarViewController {
                    tabBarVC.customTabBar.isHidden = true
                }
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 16)!]
                memberBenefitVC.title = "Quyền lợi thành viên"
            }
        } else if segue.identifier == "Show Info" {
            if let userInfoVC = segue.destination as? EditUserInfoViewController {
                if let tabBarVC = tabBarController as? TabBarViewController {
                    tabBarVC.customTabBar.isHidden = true
                }
                userInfoVC.userInfo = stateController?.user
                userInfoVC.delegate = self
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 16)!]
                userInfoVC.title = "Chỉnh sửa thông tin cá nhân"
            }
        } else if segue.identifier == "Show Address" {
            if let addressVC = segue.destination as? AddressViewController {
                if let tabBarVC = tabBarController as? TabBarViewController {
                    tabBarVC.customTabBar.isHidden = true
                }
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 16)!]
                addressVC.title = "Quản lý địa chỉ nhận hàng"
                addressVC.stateController = stateController
            }
        }
    }
    
    var stateController: StateController?
    
}

//MARK: Pass databack by delegate
extension UserViewController: EditUserInfoViewControllerDelegate {
    func update(_ userInfo: UserModel) {
        stateController?.update(userInfo: userInfo)
    }
}

extension UIView {
    func drawShadow(opacity: Float, color: CGColor) {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowPath = shadowPath.cgPath
    }
}

extension UILabel {
    func setAttributedFont(_ name: String, _ size: CGFloat,_ text: String) {
        let attributes = [NSAttributedString.Key.strokeColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:name, size: size)!]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}


