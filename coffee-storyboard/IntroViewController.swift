//
//  IntroViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/12/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin

class IntroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        let loginManager = LoginManager()
        loginManager.logOut()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
