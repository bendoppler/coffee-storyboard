//
//  TabBarViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/28/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    var customTabBar: TabBarMenu!
    var tabBarHeight: CGFloat = 75.0
    var screenHeight: CGFloat = 0.0
    let stateController = StateController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenHeight = self.view.bounds.height
        tabBarHeight = screenHeight*0.08370535714
        self.loadTabBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let shadowPath = UIBezierPath(rect: customTabBar.bounds)
        customTabBar.layer.masksToBounds = false
        customTabBar.layer.shadowColor = UIColor.black.cgColor
        customTabBar.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        customTabBar.layer.shadowOpacity = 0.4
        customTabBar.layer.shadowPath = shadowPath.cgPath
    }
    
    private func loadTabBar() {
        let tabItems: [TabItem] = [.home, .order, .pien, .user]
        
        self.setupCustomTabMenu(for: tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        for vc in self.viewControllers! {
            if vc.contents is HomeViewController {
                let homeVC = vc.contents as! HomeViewController
                homeVC.stateController = stateController
            }
            if vc.contents is UserViewController {
                let userVC = vc.contents as! UserViewController
                userVC.stateController = stateController
            }
        }
        self.selectedIndex = 0
    }
    
    private func setupCustomTabMenu(for items: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        
        //hide the tab bar
        tabBar.isHidden = true
        
        self.customTabBar = TabBarMenu(menuItems: items, frame: frame, height: screenHeight)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        
        //add it to the view
        self.view.addSubview(customTabBar)
        // Add positioning constraints to place the nav menu right where the tab bar should be
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        self.view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(of index: Int) {
        self.selectedIndex = index
    }
}
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}
