//
//  EditUserInfoViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/1/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

protocol EditUserInfoViewControllerDelegate: AnyObject {
    func update(_ userInfo: UserModel)
}

class EditUserInfoViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    // MARK: UIView style
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var familyNameView: UIView!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: ProfileImageView!
    //delegate
    weak var delegate: EditUserInfoViewControllerDelegate?
    var userInfo: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8.0, color: UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.8))
        familyNameView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 5.0, color: UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.8))
        birthdayView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8.0, color: UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.8))
        phoneNumberView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8.0, color: UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.8))
        emailView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8.0, color: UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.8))
        confirmButton.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8.0, color: UIColor(red: 255/255, green: 188/255, blue: 80/255, alpha: 0.8))
        nameTextField.delegate = self
        familyNameTextField.delegate = self
        birthdayTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = userInfo?.name ?? ""
        familyNameTextField.text = userInfo?.familyName ?? ""
        birthdayTextField.text = userInfo?.birthday ?? ""
        phoneNumberTextField.text = userInfo?.phoneNumber ?? ""
        emailTextField.text = userInfo?.email ?? ""
        if let image = userInfo?.image {
            let imageView = UIImageView(image: image)
            imageView.frame = profileImageView.bounds
            imageView.makeRounded(borderWidth: 5, color: UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 231/255).cgColor)
            profileImageView.addSubview(imageView)
            profileImageView.bringSubviewToFront(imageView)
        }
    }
    
    //MARK: Scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    {
        didSet{
            scrollView.delegate = self
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height*1.5)
    }
    
    //MARK: Text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var rc = textField.convert(textField.bounds, to: scrollView)
        rc.origin.x = 0
        rc.origin.y -= 40
        
        rc.size.height = 400
        scrollView.scrollRectToVisible(rc, animated: true)
        if textField == birthdayTextField {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
            birthdayTextField.inputView = picker
            birthdayTextField.text = formatDateForDisplay(date: picker.date)
        }
    }
    // Called when the date picker changes.
    @objc func updateDateField(sender: UIDatePicker) {
        birthdayTextField.text = formatDateForDisplay(date: sender.date)
    }

    // Formats the date chosen with the date picker.
    fileprivate func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        return formatter.string(from: date)
    }
    
    lazy var handler: [UITextField: UITextField] = [nameTextField: familyNameTextField, familyNameTextField: birthdayTextField, birthdayTextField: phoneNumberTextField, phoneNumberTextField: emailTextField]
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handler[textField]?.becomeFirstResponder()
        return false
    }
    
    //MARK: Tap
    
    @IBAction func importImage(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            CameraHandler.shared.showActionSheet(vc: self)
            CameraHandler.shared.imagePickedBlock = { [weak self] (image) in
                let imageView = UIImageView(image: image)
                self?.userInfo?.image = image
                if let frame = self?.profileImageView.bounds {
                    DispatchQueue.main.async {
                        imageView.frame = frame
                        imageView.makeRounded(borderWidth: 5, color: UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 231/255).cgColor)
                        self?.profileImageView.addSubview(imageView)
                        self?.profileImageView.bringSubviewToFront(imageView)
                    }
                }
            }
        }
    }
    
    //MARK: Save user info by delegate
    @IBAction func save(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if var userInfo = userInfo {
                if let name = nameTextField.text {
                    userInfo.name = name
                }
                if let familyName = familyNameTextField.text {
                    userInfo.familyName = familyName
                }
                if let birthday = birthdayTextField.text {
                    userInfo.birthday = birthday
                }
                if let phoneNumber = phoneNumberTextField.text {
                    userInfo.phoneNumber = phoneNumber
                }
                if let email = emailTextField.text {
                    userInfo.email = email
                }
                delegate?.update(userInfo)
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
extension UIImageView {
    func makeRounded(borderWidth: CGFloat, color: CGColor) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = color
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

