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
import FacebookCore

class LoginViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {
    let buttonRatio: CGFloat = 5/24
    var fbSigninButton: FBLoginButton? {
        didSet {
            spinner.stopAnimating()
        }
    }
    var ggSiginButton: GIDSignInButton? {
        didSet {
            spinner.stopAnimating()
        }
    }
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        if AccessToken.current == nil && GIDSignIn.sharedInstance()?.hasPreviousSignIn() != true {
            //create two sigin buttons
            let buttonWidth: CGFloat = view.bounds.width * 3 / 4
            let buttonHeight: CGFloat = buttonWidth*buttonRatio
            let magicNumber: CGFloat = view.bounds.height * 0.02232142857
            // Do any additional setup after loading the view.
            GIDSignIn.sharedInstance()?.presentingViewController = self
            let fbPosition = CGPoint(x: view.center.x-buttonWidth/2+3, y: view.center.y - buttonHeight + magicNumber - 8)
            let ggPosition = CGPoint(x: view.center.x-buttonWidth/2, y: view.center.y)
            self.fbSigninButton = FBLoginButton(frame: CGRect(origin: fbPosition, size: CGSize(width: buttonWidth-5, height: buttonHeight-magicNumber)), permissions: [.publicProfile, .email])
            self.ggSiginButton = GIDSignInButton(frame: CGRect(origin: ggPosition, size: CGSize(width: buttonWidth, height: buttonHeight)))
            let fbLayoutConstraints = self.fbSigninButton!.constraints
            for lc in fbLayoutConstraints {
                if (lc.constant == 28) {
                    lc.isActive = false
                    break;
                }
            }
            self.fbSigninButton!.delegate = self
            fbSigninButton?.isHidden = false
            ggSiginButton?.isHidden = false
            spinner.stopAnimating()
            view.addSubview(self.fbSigninButton!)
            view.addSubview(self.ggSiginButton!)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if  AccessToken.current != nil || GIDSignIn.sharedInstance()?.hasPreviousSignIn() != true {
            performSegueToIntroScreen()
        }
    }
    func performSegueToIntroScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let introVC = storyBoard.instantiateViewController(withIdentifier: "IntroMVC")
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            introVC.modalPresentationStyle = .overFullScreen
            self.present(introVC, animated: true, completion: nil)
        }
    }
    //MARK: Facebook sigin
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        if let accessToken = result?.token{
            spinner.startAnimating()
            fbSigninButton?.isHidden = true
            ggSiginButton?.isHidden = true
            let graphPath = "/me"
            let parameters: [String: Any] = ["fields": "id,first_name,last_name,email"]
            let httpMethod: HTTPMethod = .get
            
            let request = GraphRequest(graphPath: graphPath, parameters: parameters, tokenString: accessToken.tokenString, version: "v5.0", httpMethod: httpMethod)
            request.start { [weak self] response, result, error in
                if error != nil {
                    print("Cannot get user info from user token")
                }
                if let result = result as? [String:String] {
                    self?.container?.performBackgroundTask{ context in
                        try? User.saveUserInfo(userId: result["id"] ?? accessToken.userID, familyName: result["first_name"] ?? "", name: result["last_name"] ?? "", birthday: nil, phoneNumber: nil, email: result["email"] ?? "", in: context)
                        try? context.save()
                    }
                    UserDefaults.standard.set(result["id"], forKey: "userID")
                    self?.performSegueToIntroScreen()
                }
            }
        } else {
            spinner.stopAnimating()
            fbSigninButton?.isHidden = false
            ggSiginButton?.isHidden = false
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // Perform any operations when the user disconnects from app here.
    }
    
    //MARK: Google sign in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out")
                spinner.stopAnimating()
                fbSigninButton?.isHidden = false
                ggSiginButton?.isHidden = false
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        spinner.startAnimating()
        fbSigninButton?.isHidden = true
        ggSiginButton?.isHidden = true
        container?.performBackgroundTask{ context in
            try? User.saveUserInfo(userId: user.userID, familyName: user.profile.familyName, name: user.profile.name, birthday: nil, phoneNumber: nil, email: user.profile.email, in: context)
            try? context.save()
            UserDefaults.standard.set(user.userID, forKey: "userID")
        }
        self.performSegueToIntroScreen()
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
}

