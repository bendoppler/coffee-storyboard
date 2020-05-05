//
//  CouponViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/29/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class CouponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate
{
    @IBOutlet weak var searchCouponCodeView: UIView!
    @IBOutlet weak var saveCouponButton: UIButton!
    @IBOutlet weak var couponTextField: UITextField! {
        didSet {
            couponTextField.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCouponCodeView.layer.borderColor = UIColor.lightGray.cgColor
        searchCouponCodeView.layer.cornerRadius = 5.0
        saveCouponButton.layer.cornerRadius = 5.0
        
    }
    
    @IBOutlet weak var couponCollectionView: UICollectionView! {
        didSet {
            couponCollectionView.delegate = self
            couponCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var couponHistoryCollectionView: UICollectionView! {
        didSet {
            couponHistoryCollectionView.delegate = self
            couponHistoryCollectionView.dataSource = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            if let tabBarVC = tabBarController as? TabBarViewController {
                tabBarVC.customTabBar.isHidden = false
            }
        }
    }
    //MARK: UICollectionView
    var coupons: [Coupon] = [
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 7), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 14), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 21), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 28), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 35), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 30), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 2), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa.")
    ]
    var couponHistory = [
        CouponHistory(coupon: Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 7), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."), usedDate: Date()),
        CouponHistory(coupon: Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 14), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."), usedDate: Date()),
        CouponHistory(coupon: Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 21), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."), usedDate: Date())
    ]
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == couponCollectionView {
            return coupons.count
        }
        return couponHistory.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == couponCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UseCouponCell", for: indexPath)
            if let couponCell = cell as? UseCouponCollectionViewCell {
                couponCell.layer.borderWidth = 1.0
                couponCell.layer.cornerRadius = 8.0
                couponCell.layer.borderColor = UIColor.lightGray.cgColor
                couponCell.couponImageView.image = coupons[indexPath.item].image
                couponCell.descriptionLabel.text = coupons[indexPath.item].description
                couponCell.descriptionLabel.preferredMaxLayoutWidth = couponCell.descriptionLabel.bounds.width
                couponCell.nameLabel.text = coupons[indexPath.item].name
                couponCell.dateLabel.text = "Hết hạn: " + coupons[indexPath.item].date.toString()
            }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponHistoryCell", for: indexPath)
            if let couponHistoryCell = cell as? HistoryCouponCollectionViewCell {
                couponHistoryCell.layer.borderWidth = 1.0
                couponHistoryCell.layer.cornerRadius = 8.0
                couponHistoryCell.layer.borderColor = UIColor.lightGray.cgColor
                couponHistoryCell.couponNameLabel.text = couponHistory[indexPath.item].coupon.name
                couponHistoryCell.dateLabel.text = "Hết hạn: " + couponHistory[indexPath.item].coupon.date.toString() + "/ Đã sử dụng: " + couponHistory[indexPath.item].usedDate.toString()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == couponCollectionView {
            return CGSize(width: 374, height: 125)
        } else {
            return CGSize(width: 374, height: 87)
        }
    }
    
    //MARK: UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
