//
//  ViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/7/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin

class LoginViewController: UIViewController {
    
    let buttonRatio: CGFloat = 5/24
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonWidth: CGFloat = view.bounds.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth*buttonRatio
        print("height: \(view.bounds.height)")
        let magicNumber: CGFloat = view.bounds.height * 0.02232142857
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let fbPosition = CGPoint(x: view.center.x-buttonWidth/2+3, y: view.center.y - buttonHeight + magicNumber - 8)
        let ggPosition = CGPoint(x: view.center.x-buttonWidth/2, y: view.center.y)
        let fbSiginButton = FBLoginButton(frame: CGRect(origin: fbPosition, size: CGSize(width: buttonWidth-5, height: buttonHeight-magicNumber)), permissions: [.publicProfile])
        let ggSiginButton = GIDSignInButton(frame: CGRect(origin: ggPosition, size: CGSize(width: buttonWidth, height: buttonHeight)))
        view.addSubview(fbSiginButton)
        view.addSubview(ggSiginButton)
    }
    

}

