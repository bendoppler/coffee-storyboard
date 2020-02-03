//
//  NewsViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/31/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        barButtonItem.image = UIImage(named: "share")
    }
}
