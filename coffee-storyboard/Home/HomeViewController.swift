//
//  HomeViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/20/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate{
    
    @IBOutlet weak var mainBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var couponBarView: UIView!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var couponImageView: UIImageView!
    
    @IBOutlet weak var orderBarView: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var orderImageView: UIImageView!
    
    @IBOutlet weak var bonusPointBarView: UIView!
    @IBOutlet weak var bonusPointLabel: UILabel!
    @IBOutlet weak var bonusPointImageView: UIImageView!
    
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var couponsLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!

    @IBOutlet weak var appTitleBottomSpacing: NSLayoutConstraint!
    @IBOutlet weak var imageProfileBottomSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    
    @IBOutlet weak var scrollViewTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var collectionViewBottomSpacing: NSLayoutConstraint!
    @IBOutlet weak var newsLabelTopSpacing: NSLayoutConstraint!
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenHeight = self.view.bounds.height
        mainBarHeight.constant = screenHeight*0.1227678751
        couponBarView.addRightBorder(with: UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0), andWidth: 1.0)
        orderBarView.addRightBorder(with: UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0), andWidth: 1.0)
        couponBarView.roundCorners([.topLeft, .bottomLeft] , radius: 5.0, color: UIColor.white)
        bonusPointBarView.roundCorners([.topRight, .bottomRight], radius: 5.0, color: UIColor.white)
        couponLabel.font = couponLabel.font.withSize(screenHeight * 16/896)
        orderLabel.font = orderLabel.font.withSize(screenHeight * 16/896)
        bonusPointLabel.font = bonusPointLabel.font.withSize(screenHeight * 16/896)
        couponImageView.frame.size = CGSize(width: screenHeight * 42/896, height: screenHeight * 42/896)
        orderImageView.frame.size = CGSize(width: screenHeight * 39/896, height: screenHeight * 39/896)
        bonusPointImageView.frame.size = CGSize(width: screenHeight * 39/896, height: screenHeight * 39/896)
        appTitleLabel.font = appTitleLabel.font.withSize(screenHeight * 16/896)
        couponsLabel.font = couponsLabel.font.withSize(screenHeight * 16/896)
        newsLabel.font = newsLabel.font.withSize(screenHeight * 16/896)
        appTitleBottomSpacing.constant = screenHeight * 76/896
        imageProfileBottomSpacing.constant = screenHeight * 3/896
        userNameLabel.font = userNameLabel.font.withSize(screenHeight * 16/896)
        userInfoLabel.font = userInfoLabel.font.withSize(screenHeight * 16/896)
        scrollViewTopSpacing.constant = screenHeight * 53.67/896
        collectionViewBottomSpacing.constant = screenHeight * 400.33/896
        newsLabelTopSpacing.constant = screenHeight * 34/896
        if let userId = UserDefaults.standard.string(forKey: "userID"), let userInfo = Utilities.getUserInfo(userId: userId, container: container) {
            if let name = userInfo.name {
                let userName = name
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto", size: screenHeight*16/896)!]
                let boldString = NSMutableAttributedString(string: userName, attributes: attributes)
                userNameLabel.attributedText = boldString
            }
        }
    }
    
    //MARK: Collection View for coupon and news
    
    private var coupons = [UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample"), UIImage(named: "coupon-sample")]
    
    private var news = [UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample"), UIImage(named: "news-sample")]
    
    @IBOutlet weak var couponCollectionView: UICollectionView! {
        didSet {
            couponCollectionView.dataSource = self
            couponCollectionView.delegate = self
        }
    }
    
    @IBOutlet weak var newsCollectionView: UICollectionView! {
        didSet {
            newsCollectionView.delegate = self
            newsCollectionView.dataSource = self
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == couponCollectionView {
            return coupons.count
        }
        return news.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == couponCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponCell", for: indexPath)
            if let couponCell = cell as? CouponCollectionViewCell {
                couponCell.imageView.image = coupons[indexPath.item]
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
            if let couponCell = cell as? NewsCollectionViewCell {
                couponCell.imageView.image = news[indexPath.item]
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height = self.view.bounds.height
        if collectionView == couponCollectionView {
            return CGSize(width: height*200/896, height: height*138/896)
        } else {
            return CGSize(width: height*414/896, height: height*339/896)
        }
    }
    
    //MARK: Scrollview


    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.delegate = self
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 3/4)
        scrollViewHeight.constant = self.view.frame.height * 2/3
    }
    
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners,cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.lineWidth = 3.0
        mask.strokeColor = color.cgColor
        self.layer.mask = mask
    }
}
