//
//  OrderViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/28/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{

    
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var promotionButton: UIButton!
    @IBOutlet weak var timeDeliveryButton: UIButton!

    var categories : [Category] = []
    var selectedIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Utilities.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressButton.layer.cornerRadius = 5.0
        addressButton.layer.borderColor = UIColor.lightGray.cgColor
        promotionButton.layer.cornerRadius = 5.0
        promotionButton.layer.borderColor = UIColor.lightGray.cgColor
        timeDeliveryButton.layer.cornerRadius = 5.0
        timeDeliveryButton.layer.borderColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Collection view
    @IBOutlet weak var categoryCollectionView: UICollectionView! {
        didSet {
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath)
        if let categoryCell = cell as? CategoryCollectionViewCell {
            categoryCell.layer.cornerRadius = 5.0
            categoryCell.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
            categoryCell.nameLabel.text = categories[indexPath.item].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: "Show Order Detail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        return CGSize(width: width * 0.45, height: height / 8)
    }
    //MARK: Button action
    @IBAction func showMapScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "Show Map", sender: self)
    }
    
    @IBAction func showCouponScreen(_ sender: Any) {
        performSegue(withIdentifier: "Show Order Coupon", sender: self)
    }
    
    //MARK: Segue
    var stateController: StateController?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Map" {
            if let mapVC = segue.destination.contents as? MapViewController {
                mapVC.stateController = stateController
                mapVC.updateOrderLocationClosure = { [weak self] location in
                    DispatchQueue.main.async {
                        self?.addressButton.setTitle(location.name, for: .normal)
                    }
                }
            }
        } else if segue.identifier == "Show Order Coupon" {
            if let tabBarVC = tabBarController as? TabBarViewController {
                tabBarVC.customTabBar.isHidden = true
            }
            if let couponVC = segue.destination.contents as? CouponViewController {
                couponVC.title = "Ưu đãi của bạn"
            }
        } else if segue.identifier == "Show Order Detail" {
            if let orderDetailVC = segue.destination.contents as? OrderDetailViewController {
                if let tabBarVC = tabBarController as? TabBarViewController {
                    tabBarVC.customTabBar.isHidden = true
                }
                if let selectedIndex = selectedIndex {
                    orderDetailVC.selectedIndex = selectedIndex
                }
                orderDetailVC.categories = categories
                orderDetailVC.stateController = stateController
            }
        }
    }
    
}
