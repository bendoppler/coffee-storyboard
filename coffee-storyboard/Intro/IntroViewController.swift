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
    
    @IBOutlet weak var bottomSpacePoint: NSLayoutConstraint!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    
    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var topSpaceMaskImage: NSLayoutConstraint!
    
    @IBOutlet weak var topSpaceRectImage: NSLayoutConstraint!
    
    @IBOutlet weak var maskImageView: UIImageView!
    
    @IBOutlet weak var rectImageView: UIImageView!
    
    
    @IBAction func nextIntro(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            switch sender.state {
            case .ended:
                if self.restorationIdentifier == "lastIntro" {
                    self.performSegue(withIdentifier: "Show Home", sender: self)
                } else {
                    self.performSegue(withIdentifier: "Next Intro", sender: self)
                }
            default:
                break
            }
        }
        if sender.direction == .right {
            switch sender.state {
            case .ended:
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = view.bounds.size.height
        if self.restorationIdentifier == "lastIntro" {
            rectImageView.isHidden = true
            maskImageView.isHidden = false
        }
        bottomSpacePoint.constant = height / 4
        welcomeLabel.font = welcomeLabel.font.withSize(height * 0.0413)
        pointLabel.font = pointLabel.font.withSize(height * 0.038)
        introLabel.font = introLabel.font.withSize(height/56)
        topSpaceMaskImage.constant = height / 13
        topSpaceRectImage.constant = height / 9
    }
}
