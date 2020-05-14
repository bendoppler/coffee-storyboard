//
//  PopupWindow.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 5/14/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class PopupWindow: UIViewController {
    let popupWindowView = PopupWindowView()
    
    init(title: String, text: String, buttonText: String) {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        popupWindowView.popupTitle.text = title
        popupWindowView.popupText.text = text
        popupWindowView.popupFollowButton.setTitle(buttonText, for: .normal)
        popupWindowView.popupOkButton.setTitle("OK", for: .normal)
        popupWindowView.popupFollowButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        popupWindowView.popupOkButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.view = popupWindowView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

class PopupWindowView: UIView {
    let popupView = UIView(frame: CGRect.zero)
    let popupTitle = UILabel(frame: CGRect.zero)
    let popupText = UILabel(frame: CGRect.zero)
    let popupFollowButton = UIButton(frame: CGRect.zero)
    let popupOkButton = UIButton(frame: CGRect.zero)
    
    let borderWidth: CGFloat = 2.0
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        //popup background
        popupView.backgroundColor = UIColor.white
        popupView.layer.masksToBounds = true
        
        //popup title
        popupTitle.backgroundColor = UIColor.white
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont(name: "Roboto-Bold", size: 16.0)
        popupTitle.numberOfLines = 1
        popupTitle.textAlignment = .center
        
        //popup text
        popupText.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        popupText.font = UIFont(name: "Roboto-Regular", size: 16.0)
        popupText.numberOfLines = 0
        popupText.textAlignment = .center
        
        //popup follow button
        popupFollowButton.setTitleColor(UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0), for: .normal)
        popupFollowButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16.0)
        popupFollowButton.backgroundColor = UIColor(red: 1, green: 206/255, blue: 80/255, alpha: 1.0)
        
        //ok button
        popupOkButton.setTitleColor(UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0), for: .normal)
        popupOkButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16.0)
        popupOkButton.backgroundColor = UIColor.white
        popupOkButton.layer.borderWidth = 1.0
        popupOkButton.layer.borderColor = UIColor(red: 1, green: 206/255, blue: 80/255, alpha: 1.0).cgColor
        
        popupView.addSubview(popupTitle)
        popupView.addSubview(popupText)
        popupView.addSubview(popupFollowButton)
        popupView.addSubview(popupOkButton)
        
        addSubview(popupView)
        
        //popup view constraint
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.layer.cornerRadius = 5.0
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 350),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        //popup title constraint
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 37),
            popupTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        //popup text constraint
        popupText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupText.heightAnchor.constraint(greaterThanOrEqualToConstant: 75),
            popupText.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant:  12),
            popupText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 26),
            popupText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -26),
        ])
        
        popupFollowButton.translatesAutoresizingMaskIntoConstraints = false
        popupFollowButton.layer.cornerRadius = 2.0
        NSLayoutConstraint.activate([
            popupFollowButton.heightAnchor.constraint(equalToConstant: 40),
            popupFollowButton.topAnchor.constraint(equalTo: popupText.bottomAnchor, constant: 23),
            popupFollowButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 16),
            popupFollowButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
            popupFollowButton.bottomAnchor.constraint(equalTo: popupOkButton.topAnchor, constant: -12)
        ])
        
        popupOkButton.translatesAutoresizingMaskIntoConstraints = false
        popupOkButton.layer.cornerRadius = 2.0
        NSLayoutConstraint.activate([
            popupOkButton.heightAnchor.constraint(equalToConstant: 40),
            popupOkButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 16),
            popupOkButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
            popupOkButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -42)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




