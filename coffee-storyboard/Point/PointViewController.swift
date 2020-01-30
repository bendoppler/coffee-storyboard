//
//  PointViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/29/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class PointViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = couponCollectionView.collectionViewLayout as? UICollectionViewFlowLayout // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    //MARK: Collection view
    var coupons: [Coupon] = [
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 7), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 14), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 21), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 28), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 35), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 30), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa."),
        Coupon(name: "Free drink", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: UIImage(named: "coupon_sample_image")!, from: Date(), date: Date(timeIntervalSinceNow: 86400 * 2), fullDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ante eu lorem vulputate porta. Duis ante nibh, blandit vel neque non, interdum rutrum dui. Vestibulum a faucibus justo, a mattis augue. Morbi non metus feugiat, consectetur dolor nec, vehicula enim. Fusce eu felis sit amet arcu ornare faucibus sit amet ut massa.")
    ]
    @IBOutlet weak var couponCollectionView: UICollectionView!{
        didSet {
            couponCollectionView.delegate = self
            couponCollectionView.dataSource = self
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coupons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CouponHeaderCell", for: indexPath)
        return headerView
    }
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}

extension UILabel {
    var optimalHeight: CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
    }
}
