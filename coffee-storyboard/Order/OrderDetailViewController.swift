//
//  OrderDetailViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 2/2/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class OrderDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCategoryTabBarView()
        checkOrderButton.layer.cornerRadius = 8.0
        checkOrderButton.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
    }

    private func setUpCategoryTabBarView() {
        let width = foodTabBarView.bounds.width
        let height = foodTabBarView.bounds.height
        if let categories = categories {
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 143/255, green: 143/255, blue: 143/255, alpha: 1.0),
                NSAttributedString.Key.font: UIFont(name: "Roboto", size: 16.0)!
            ]
            let cnt = categories.count
            for index in 0..<cnt {
                let frame = CGRect(x: 15 + CGFloat(index) * width/CGFloat(cnt), y: foodTabBarView.frame.origin.y, width: width/CGFloat(cnt), height: height)
                let categoryLabel = PaddingLabel(withInsets: 0, 0, 15, 0)
                categoryLabel.frame = frame
                let attributedString = NSAttributedString(string: categories[index].name, attributes: attributes)
                categoryLabel.attributedText = attributedString
                if selectedIndex == index {
                    categoryLabel.addBottomBorder(with: UIColor(red: 1, green: 199/255, blue: 0, alpha: 1.0), andWidth: 1.0)
                    let selectedAttributes: [NSAttributedString.Key: Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 199/255, blue: 0, alpha: 1.0),
                        NSAttributedString.Key.font: UIFont(name: "Roboto", size: 16.0)!
                    ]
                    let selectedString = NSAttributedString(string: categories[index].name, attributes: selectedAttributes)
                    categoryLabel.attributedText = selectedString
                }else {
                    categoryLabel.addBottomBorder(with: UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 212/255), andWidth: 1.0)
                }
                let gesture = UITapGestureRecognizer(target: self, action: #selector(showFoodInCategory(_:)))
                categoryLabel.isUserInteractionEnabled = true
                categoryLabel.addGestureRecognizer(gesture)
                categoryLabel.tag = index
                self.foodTabBarView.addSubview(categoryLabel)
            }
        }
    }
    
    @objc func showFoodInCategory(_ sender: AnyObject) {
        selectedIndex = sender.view.tag
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 143/255, green: 143/255, blue: 143/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "Roboto", size: 16.0)!
        ]
        let cnt = foodTabBarView.subviews.count
        for index in 0..<cnt {
            if let subview = foodTabBarView.subviews[index] as? PaddingLabel {
                if selectedIndex == index {
                    foodTabBarView.subviews[index].addBottomBorder(with: UIColor(red: 1, green: 199/255, blue: 0, alpha: 1.0), andWidth: 1.0)
                    let selectedAttributes: [NSAttributedString.Key: Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 199/255, blue: 0, alpha: 1.0),
                        NSAttributedString.Key.font: UIFont(name: "Roboto", size: 16.0)!
                    ]
                    let selectedString = NSAttributedString(string: subview.text!, attributes: selectedAttributes)
                    subview.attributedText = selectedString
                 }else {
                    subview.addBottomBorder(with: UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 212/255), andWidth: 1.0)
                    let attributedString = NSAttributedString(string: subview.text!, attributes: attributes)
                    subview.attributedText = attributedString
                 }
            }
        }
        foodCollectionView.reloadData()
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var foodTabBarView: UIView!
    @IBOutlet weak var checkOrderButton: UIButton!
    
    var categories: [Category]?
    var selectedIndex = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressView.layer.cornerRadius = 5.0
        addressView.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
        foodView.layer.cornerRadius = 5.0
        foodView.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
        topView.drawShadow(opacity: 1.0, color: UIColor.lightGray.cgColor)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backToMainScreen(_:)))
        backButton.addGestureRecognizer(gesture)
        navigationController?.navigationBar.isHidden = true
        if let stateController = stateController, stateController.order.foods.count > 0 {
            checkOrderButton.isHidden = false
            checkOrderButton.setTitle("XEM GIỎ HÀNG(" + stateController.order.totalPrice.convertToCurrency() + " vnđ)", for: .normal)
        }else {
            checkOrderButton.isHidden = true
        }
    }
    
    @objc func backToMainScreen(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: Collection view
    
    @IBOutlet weak var foodCollectionView: UICollectionView! {
        didSet {
            foodCollectionView.delegate = self
            foodCollectionView.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let categories = categories {
            return categories[selectedIndex].foods.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemCell", for: indexPath)
        if let foodCell = cell as? FoodItemCollectionViewCell {
            foodCell.pickItemButton.layer.cornerRadius = 5.0
            foodCell.nameLabel.text = categories![selectedIndex].foods[indexPath.item].name
            foodCell.foodImageView.image = categories![selectedIndex].foods[indexPath.item].image
            foodCell.priceLabel.text = categories![selectedIndex].foods[indexPath.item].price.convertToCurrency() + " vnđ"
            foodCell.sizeLabel.text = categories![selectedIndex].foods[indexPath.item].size
            foodCell.infoView.layer.borderColor = UIColor.clear.cgColor
            foodCell.infoView.layer.cornerRadius = 5.0
            foodCell.infoView.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseFood(_:)))
            foodCell.pickItemButton.isUserInteractionEnabled = true
            foodCell.pickItemButton.tag = indexPath.row
            foodCell.pickItemButton.addGestureRecognizer(gesture)
        }
        return cell
    }
    var selectedFoodIndex: Int?
    @objc func chooseFood(_ sender: AnyObject) {
        selectedFoodIndex = sender.view.tag
        print(sender)
        performSegue(withIdentifier: "Show Food", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 186)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Food" {
            navigationController?.navigationBar.isHidden = false
            if let foodOrderVC = segue.destination as? FoodOrderViewController {
                if let selectedFoodIndex = selectedFoodIndex {
                    if let categories = categories {
                        foodOrderVC.title = categories[selectedIndex].foods[selectedFoodIndex].name
                        foodOrderVC.order = stateController?.order
                        foodOrderVC.food = categories[selectedIndex].foods[selectedFoodIndex]
                        foodOrderVC.updateOrderClosure = { [weak self] order in
                            self?.stateController?.update(order: order)
                        }
                    }
                }
            }
        }
        else if segue.identifier == "Show Payment" {
            navigationController?.navigationBar.isHidden = false
            if let paymentVC = segue.destination as? PaymentViewController
            {
                paymentVC.title = "Giỏ hàng"
                paymentVC.order = stateController?.order
            }
        }
    }
    
    //MARK: State Controller
    var stateController: StateController?
}

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}

extension Int64 {
    func convertToCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
