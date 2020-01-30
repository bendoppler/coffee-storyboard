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
    @IBOutlet weak var profileImageView: UIImageView!
    
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
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.showPointScreen(_:)))
        bonusPointBarView.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.showCouponScreen(_:)))
        couponBarView.addGestureRecognizer(gesture2)
    }
    
    //MARK: Go to next screens
    @objc func showPointScreen(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            performSegue(withIdentifier: "Show Point", sender: self)
        }
    }
    
    @objc func showCouponScreen(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            performSegue(withIdentifier: "Show Coupon", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Point" {
            if let tabBarVC = tabBarController as? TabBarViewController {
                tabBarVC.customTabBar.isHidden = true
            }
            if let pointVC = segue.destination as? PointViewController {
                pointVC.title = "Quét mã thành viên"
            }
        } else if segue.identifier == "Show Coupon" {
            if let tabBarVC = tabBarController as? TabBarViewController {
                tabBarVC.customTabBar.isHidden = true
            }
            if let couponVC = segue.destination as? CouponViewController {
                couponVC.title = "Ưu đãi của bạn"
            }
        }
    }
    //MARK: Passing data between tab views
    var stateController: StateController?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let screenHeight = self.view.bounds.height
        navigationController?.navigationBar.isHidden = true
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.customTabBar.isHidden = false
        }
        if let addresses = stateController?.savedLocations, addresses.count > 0 {
            updateAddressesCoreData(addresses: addresses)
        }
        if let user = stateController?.user{
            if user.name != "" {
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto-Bold", size: screenHeight*16/896)!]
                let boldString = NSAttributedString(string: user.name, attributes: attributes)
                userNameLabel.attributedText = boldString
            }
            if let image = stateController?.user.image {
                profileImageView.image = image
                profileImageView.makeRounded(borderWidth: 0, color: UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 231/255).cgColor)
            }
            updateUserInfoInCoreData()
        }
        if let userId = UserDefaults.standard.string(forKey: "userID"), let userInfo = Utilities.getUserInfo(userId: userId, container: container) {
            if let name = userInfo.name {
                stateController?.user.name = name
                let userName = name
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"Roboto-Bold", size: screenHeight*16/896)!]
                let boldString = NSAttributedString(string: userName, attributes: attributes)
                userNameLabel.attributedText = boldString
            }
            if let familyName = userInfo.family_name {
                stateController?.user.familyName = familyName
            }
            if let birthday = userInfo.birthday {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                stateController?.user.birthday = formatter.string(from: birthday)
            }
            if userInfo.phone_number > 0 {
                stateController?.user.phoneNumber = String(userInfo.phone_number)
            }
            if let email = userInfo.email {
                stateController?.user.email = email
            }
            if let data = userInfo.image {
                let image = UIImage(data: data)
                stateController?.user.image = image
                profileImageView.image = image
                profileImageView.makeRounded(borderWidth: 5, color: UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 231/255).cgColor)
            }
        }
        
        if let addresses = Utilities.getAddresses(container: container), addresses.count > 0 {
            var locations: [Location] = []
            addresses.unique.forEach {
                locations.append(Location(name: $0.name, latitude: $0.latitude, longitude: $0.longitude))
            }
            stateController?.update(savedAddress: locations)
        }
        
        if let addresses = Utilities.getRecentAddresses(container: container), addresses.count > 0 {
            var locations: [Location] = []
            addresses.unique.forEach {
                locations.append(Location(name: $0.name, latitude: $0.latitude, longitude: $0.longitude))
            }
            stateController?.update(recentAddress: locations)
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
    
    //MARK: Import image
    @IBAction func importImage(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            CameraHandler.shared.showActionSheet(vc: self)
            CameraHandler.shared.imagePickedBlock = { [weak self] (image) in
                self?.profileImageView.image = image
                self?.profileImageView.makeRounded(borderWidth: 5, color: UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 231/255).cgColor)
                self?.stateController?.user.image = image
                self?.updateUserInfoInCoreData()
            }
        }
    }
    
    //MARK: Core data
    private func updateUserInfoInCoreData(){
        if let userId = UserDefaults.standard.string(forKey: "userID") {
            container?.performBackgroundTask{ [weak self] (context) in
                if let stateController = self?.stateController {
                    try? User.updateUserInfo(userId: userId, familyName: stateController.user.familyName, name: stateController.user.name, birthday: stateController.user.birthday.toDate(), phoneNumber: NumberFormatter().number(from: (stateController.user.phoneNumber))?.int64Value, email: stateController.user.email, image: stateController.user.image?.pngData(), in: context)
                }
            }
        }
    }
    private func updateAddressesCoreData(addresses: [Location]) {
        container?.performBackgroundTask({ (context) in
            addresses.forEach {
                try? Address.saveAddress(name: $0.name, latitude: $0.latitude, longitude: $0.longitude, in: context)
            }
        })
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

extension String {

    func toDate(withFormat format: String = "dd/MM/yyyy")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

