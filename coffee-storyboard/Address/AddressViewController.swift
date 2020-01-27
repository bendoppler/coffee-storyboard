//
//  AddressViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/16/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class AddressViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var addAddressView: UIView!
    var addresses: [String] = []
    var stateController: StateController?
    var selectedIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.showMapScreen(_:)))
        self.addAddressView.addGestureRecognizer(gesture)
        addAddressView.layer.cornerRadius = 8.0
        addAddressView.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
    }
    
    private func resizeCollectionViewHeight() {
        self.addressCollectionView.reloadData()
        self.addressCollectionView.performBatchUpdates(nil) { [weak self] (result) in
            let screenHeight = self?.view.bounds.height
            let height = self?.addressCollectionView.collectionViewLayout.collectionViewContentSize.height
            if height! < screenHeight! * (661 / 896) {
                DispatchQueue.main.async {
                    self?.addressCollectionViewHeight.constant = height! == 0 ? 1 : height! + 10
                    self?.view.layoutIfNeeded()
                }
            }else {
                DispatchQueue.main.async {
                    self?.addressCollectionViewHeight.constant = screenHeight! * (661 / 896)
                    self?.view.layoutIfNeeded()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = stateController?.user {
            updateUserInfoInCoreData()
        }
        if let addresses = stateController?.savedLocations, addresses.count > 0 {
            updateAddressesCoreData(addresses: addresses)
        }
        if let stateController = stateController {
            var tmpAddresses: [String] = []
            stateController.savedLocations.unique.forEach {
                if $0.name != "" {
                    tmpAddresses.append($0.name)
                }
            }
            if tmpAddresses.count > 0 {
                addresses.removeAll()
                addresses = tmpAddresses
            }
        }
        resizeCollectionViewHeight()
    }
    @objc func showMapScreen(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "Show Map", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Map" {
            if let mapVC = segue.destination.contents as? MapViewController {
                mapVC.stateController = stateController
                if let selectedIndex = selectedIndex {
                    let selectedLocations = stateController?.savedLocations.unique.filter { $0.name == addresses[selectedIndex] }
                    if let selectedLocations = selectedLocations, selectedLocations.count > 0 {
                        mapVC.currentLocation = selectedLocations[0]
                    }
                }
            }
        }
    }
    
    //MARK: Address Collection view
    
    @IBOutlet weak var addressCollectionViewHeight: NSLayoutConstraint!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    @IBOutlet weak var addressCollectionView: UICollectionView! {
        didSet {
            addressCollectionView.dataSource = self
            addressCollectionView.delegate = self
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Location Cell", for: indexPath)
        if let locationCell = cell as? AddressCollectionViewCell {
            locationCell.houseNameLabel.text = "Nhà " + String(indexPath.row + 1)
            locationCell.addressLabel.text = addresses[indexPath.row]
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.editAddress(_:)))
            locationCell.editImageView.isUserInteractionEnabled =  true
            locationCell.editImageView.tag = indexPath.row
            locationCell.editImageView.addGestureRecognizer(gesture)
            let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.deleteAddress(_:)))
            locationCell.deleteImageVIew.isUserInteractionEnabled = true
            locationCell.deleteImageVIew.tag = indexPath.row
            locationCell.deleteImageVIew.addGestureRecognizer(gesture2)
        }
        cell.layer.cornerRadius = 5.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.drawShadow(opacity: 0.8, color: UIColor.lightGray.cgColor)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 384, height: 107)
    }
    
    //MARK: Edit address
    
    @objc func editAddress(_ sender: AnyObject) {
        selectedIndex = sender.view.tag
        UserDefaults.standard.set(addresses[sender.view.tag], forKey: "address")
        performSegue(withIdentifier: "Show Map", sender: self)
    }
    
    //MARK: Delete address
    @objc func deleteAddress(_ sender: AnyObject) {
        stateController?.delete(address: addresses[sender.view.tag])
        let index = sender.view.tag
        let address = addresses[sender.view.tag]
        addresses.remove(at: index)
        resizeCollectionViewHeight()
        container?.performBackgroundTask({(context) in
            try? Address.deleteAddress(name: address, in: context)
        })
    }
    
    //MARK: Core data
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
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

extension Array where Element: Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
