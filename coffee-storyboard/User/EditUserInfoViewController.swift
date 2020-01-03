//
//  EditUserInfoViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/1/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            familyNameTextField.becomeFirstResponder()
        } else if textField == familyNameTextField {
            textField.resignFirstResponder()
            birthdayTextField.becomeFirstResponder()
        } else if textField == birthdayTextField {
            textField.resignFirstResponder()
            phoneNumberTextField.becomeFirstResponder()
        } else if textField == phoneNumberTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

