//
//  AddressViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/16/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var addAddressView: UIView!
    var addresses: [String] = []
    var stateController: StateController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.showMapScreen(_:)))
        self.addAddressView.addGestureRecognizer(gesture)
        addAddressView.layer.cornerRadius = 8.0
        addAddressView.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
        if let stateController = stateController {
            stateController.addresses.forEach {
                addresses.append($0.name)
            }
        }
    }
    
    @objc func showMapScreen(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "Show Map", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Map" {
            if let mapVC = segue.destination.contents as? MapViewController {
                mapVC.stateController = stateController
            }
        }
    }
    
    //MARK: Address Collection view
    
    @IBOutlet weak var addressCollectionViewHeight: NSLayoutConstraint!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addressCollectionView.invalidateIntrinsicContentSize()
        self.addressCollectionView.performBatchUpdates(nil) { [weak self] (result) in
            let screenHeight = self?.view.bounds.height
            let height = self?.addressCollectionView.collectionViewLayout.collectionViewContentSize.height
            if height! < screenHeight! * (661 / 896) {
                DispatchQueue.main.async {
                    self?.addressCollectionViewHeight.constant = height!
                    self?.view.layoutIfNeeded()
                }
            }
        }
    }
    @IBOutlet weak var addressCollectionView: UICollectionView! {
        didSet {
            addressCollectionView.delegate = self
            addressCollectionView.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Location Cell", for: indexPath)
        if let locationCell = cell as? AddressCollectionViewCell {
            locationCell.houseNameLabel.text = "Nhà" + String(indexPath.row + 1)
            locationCell.addressLabel.text = addresses[indexPath.row]
        }
        return cell
    }
}

extension UICollectionView {
}
