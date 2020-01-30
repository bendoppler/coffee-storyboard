//
//  TabItem.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/28/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
enum TabItem: String, CaseIterable {
    case home = "home"
    case order = "đặt hàng"
    case pien = "p.i.e.n"
    case user = "user"
    
    var viewController: UIViewController {
        switch self {
        case .home:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyBoard.instantiateViewController(withIdentifier: "RootVC")
            return rootVC
        case .order:
            return OrderViewController()
        case .pien:
            return PienViewController()
        case .user:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let userVC = storyBoard.instantiateViewController(withIdentifier: "UserMVC")
            return userVC
        }
    }
    
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(named: "home-yellow")!
        case .order:
            return UIImage(named: "cart")!
        case .pien:
            return UIImage(named: "pien")!
        case .user:
            return UIImage(named: "user")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
