//
//  PaymentViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 4/23/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class PaymentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var stateController: StateController?
    //MARK: Address screen
    @IBOutlet weak var addAddressLabel: UILabel!
    @objc func showMapScreen(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "Show Map", sender: self)
    }
    
    //MARK: Coupon screen
    @IBOutlet weak var couponLabel: UILabel!
    @objc func showCouponScreen(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "Show Coupon", sender: self)
    }
    
    //MARK: Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Map" {
            if let mapVC = segue.destination.contents as? MapViewController {
                mapVC.stateController = stateController
                if let selectedIndex = selectedIndex {
                    let selectedLocations = stateController?.savedLocations.unique.filter {
                        $0.name == addresses[selectedIndex]
                    }
                    if let selectedLocations = selectedLocations, selectedLocations.count > 0 {
                        mapVC.currentLocation = selectedLocations[0]
                    }
                }
            }
        }
    }
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.foodCollectionView.reloadData()
        // Do any additional setup after loading the view.
        if let addresses = Utilities.getAddresses(container: container), addresses.count > 0 {
            var locations: [Location] = []
            addresses.unique.forEach {
                locations.append(Location(name: $0.name, latitude: $0.latitude, longitude: $0.longitude))
            }
            stateController?.update(savedAddress: locations)
        }
        if let stateController = stateController {
            priceLabel.text = stateController.order.totalPrice.convertToCurrency() + " vnđ"
            totalPriceLabel.text = stateController.order.totalPrice.convertToCurrency() + " vnđ"
        }
        confirmButton.layer.cornerRadius = 5.0
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.showMapScreen(_:)))
        self.addAddressLabel.addGestureRecognizer(gesture)
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.showCouponScreen(_:)))
        self.couponLabel.addGestureRecognizer(gesture1)
    }
    
    //MARK: Address variables
    var addresses: [String] = []
    var selectedIndex: Int?
    //MARK: Payment variables
    var payments = ["Thanh toán khi nhận hàng", "Thanh toán khi nhận hàng", "Thanh toán khi nhận hàng"]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let addresses = stateController?.savedLocations, addresses.count > 0 {
            updateAddressCoreData(addresses: addresses)
        }
        if let stateController = stateController {
            priceLabel.text = stateController.order.totalPrice.convertToCurrency() + " vnđ"
            totalPriceLabel.text = stateController.order.totalPrice.convertToCurrency() + " vnđ"
            var tmp : [String] = []
            stateController.savedLocations.unique.forEach {
                if $0.name != "" {
                    tmp.append($0.name)
                }
            }
            if tmp.count > 0 {
                addresses.removeAll()
                addresses = tmp
            }
        }
        self.addressCollectionView.reloadData()
    }
    
    private func updateAddressCoreData(addresses: [Location]) {
        container?.performBackgroundTask({ (context) in
            addresses.forEach {
                try? Address.saveAddress(name: $0.name, latitude: $0.latitude, longitude: $0.longitude, in: context)
            }
        })
    }
    
    //MARK: Collection view: food, address, promotion, payment
    @IBOutlet weak var foodCollectionView: UICollectionView! {
        didSet {
            foodCollectionView.delegate = self
            foodCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var addressCollectionView: UICollectionView! {
        didSet {
            addressCollectionView.delegate = self
            addressCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var paymentCollectionView: UICollectionView! {
        didSet {
            paymentCollectionView.delegate = self
            paymentCollectionView.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == foodCollectionView {
            return stateController!.order.foods.count
        }else if collectionView == addressCollectionView {
            return addresses.count
        }
        return payments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == foodCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemCell", for: indexPath)
            if let foodCell = cell as? PaymentFoodItemCollectionViewCell, let order = stateController?.order{
                foodCell.nameLabel.text = order.foods[indexPath.item].food.name
                foodCell.sizeLabel.text = order.foods[indexPath.item].food.size
                foodCell.priceLabel.text = order.foods[indexPath.item].food.price.convertToCurrency() + " vnđ"
                foodCell.foodCntLabel.text = String(order.foods[indexPath.item].cnt)
            }
            return cell
        }else if collectionView == addressCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Location Cell", for: indexPath)
            if let locationCell = cell as? AddressCollectionViewCell {
                locationCell.houseNameLabel.text = "Nhà " + String(indexPath.row + 1)
                locationCell.addressLabel.text = addresses[indexPath.row]
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.editAddress(_:)))
                locationCell.editImageView.isUserInteractionEnabled =  true
                locationCell.editImageView.tag = indexPath.row
                locationCell.editImageView.addGestureRecognizer(gesture)
            }
            return cell

        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Payment Cell", for: indexPath)
        if let paymentCell = cell as? PaymentCollectionViewCell {
            paymentCell.label.text = payments[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == foodCollectionView {
            print("width: \(collectionView.frame.width), height: \(collectionView.frame.height)")
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else if collectionView == addressCollectionView {
            print("awidth: \(collectionView.frame.width), height: \(collectionView.frame.height)")
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize(width: collectionView.frame.width*2/3, height: collectionView.frame.height)
        
    }
    
    //MARK: Edit address
    
    @objc func editAddress(_ sender: AnyObject) {
        selectedIndex = sender.view.tag
        UserDefaults.standard.set(addresses[sender.view.tag], forKey: "address")
        performSegue(withIdentifier: "Show Map", sender: self)
    }
    
    //MARK: Price
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBAction func confrimOrder(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
