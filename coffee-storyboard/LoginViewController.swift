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
import CoreData

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    let buttonRatio: CGFloat = 5/24
    var fbSigninButton: FBLoginButton!
    var ggSiginButton: GIDSignInButton!
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        //create two sigin buttons
        let buttonWidth: CGFloat = view.bounds.width * 3 / 4
        let buttonHeight: CGFloat = buttonWidth*buttonRatio
        let magicNumber: CGFloat = view.bounds.height * 0.02232142857
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let fbPosition = CGPoint(x: view.center.x-buttonWidth/2+3, y: view.center.y - buttonHeight + magicNumber - 8)
        let ggPosition = CGPoint(x: view.center.x-buttonWidth/2, y: view.center.y)
        self.fbSigninButton = FBLoginButton(frame: CGRect(origin: fbPosition, size: CGSize(width: buttonWidth-5, height: buttonHeight-magicNumber)), permissions: [.publicProfile])
        self.ggSiginButton = GIDSignInButton(frame: CGRect(origin: ggPosition, size: CGSize(width: buttonWidth, height: buttonHeight)))
        let fbLayoutConstraints = self.fbSigninButton.constraints
        for lc in fbLayoutConstraints {
            if (lc.constant == 28) {
                lc.isActive = false
                break;
            }
        }
        view.addSubview(self.fbSigninButton)
        view.addSubview(self.ggSiginButton)
    }
    
    //MARK: Google sign in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        container?.performBackgroundTask{ context in
            // Perform any operations on signed in user here.
            try? User.saveUserInfo(userId: user.userID, familyName: user.profile.familyName, name: user.profile.name, birthday: nil, phoneNumber: nil, email: user.profile.email, in: context)
            try? context.save()
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let introVC = storyBoard.instantiateViewController(withIdentifier: "IntroMVC")
        self.present(introVC, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }

}

