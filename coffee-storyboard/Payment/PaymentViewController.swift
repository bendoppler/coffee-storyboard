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
    //MARK: Coredata
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.foodCollectionView.reloadData()
        // Do any additional setup after loading the view.
        if let context = container?.viewContext {
            if let persitentAddress = try? Address.retrieveAddresses(in: context)
            {
                persitentAddress.unique.forEach { [weak self] in
                    if let name = $0.name {
                        self?.stateController?.savedLocations.append(Location(name: name, latitude: $0.latitude, longitude: $0.longitude))
                        
                    }
                }
            }
        }
    }
    
    //MARK: Address variables
    var addresses: [String] = []
    var selectedIndex: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let stateController = stateController {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == foodCollectionView {
            return stateController!.order.foods.count
        }else if collectionView == addressCollectionView {
            return addresses.count
        }
        return 0
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
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == foodCollectionView {
            print("width: \(collectionView.frame.width), height: \(collectionView.frame.height)")
        }else if collectionView == addressCollectionView {
            print("awidth: \(collectionView.frame.width), height: \(collectionView.frame.height)")
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    //MARK: Edit address
    
    @objc func editAddress(_ sender: AnyObject) {
        selectedIndex = sender.view.tag
        UserDefaults.standard.set(addresses[sender.view.tag], forKey: "address")
        performSegue(withIdentifier: "Show Map", sender: self)
    }
}
