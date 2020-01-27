//
//  StateController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 12/31/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import Foundation
import UIKit

struct UserModel {
    var name: String
    var familyName: String
    var birthday: String
    var phoneNumber: String
    var email: String
    var image: UIImage?
    init(name: String? = nil, familyName: String? = nil, birthday: String? = nil, phoneNumber: String? = nil, email: String? = nil, image: UIImage? = nil) {
        self.name = name ?? ""
        self.familyName = familyName ?? ""
        self.birthday = birthday ?? ""
        self.phoneNumber = phoneNumber ?? ""
        self.email = email ?? ""
        self.image = image ?? nil
    }
}

struct Location: Hashable{
    var name: String
    var latitude: Double
    var longitude: Double
    init(name: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self.name = name ?? ""
        self.latitude = latitude ?? -100
        self.longitude = latitude ?? -200
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}

class StateController {
    var user: UserModel = UserModel()
    var savedLocations: [Location] = []
    var recentLocations: [Location] = []
    
    func update(userInfo: UserModel) {
        user.name = userInfo.name
        user.familyName = userInfo.familyName
        user.birthday = userInfo.birthday
        user.phoneNumber = userInfo.phoneNumber
        user.email = userInfo.email
        user.image = userInfo.image
    }
    
    func update(recentAddress: [Location]) {
        recentLocations.update(addresses: recentAddress)
    }
    
    func update(savedAddress: [Location], address: String? = nil, location: Location? = nil) {
        if let address = address, let location = location {
            for index in 0..<savedLocations.count {
                if savedLocations[index].name == address {
                    savedLocations[index] = location
                }
            }
        }else {
            savedLocations.update(addresses: savedAddress)
        }
    }
    
    func delete(address: String) {
        for index in 0..<savedLocations.count {
            if savedLocations[index].name == address {
                savedLocations.remove(at: index)
                break
            }
        }
    }
}

extension Array where Element == Location {
    mutating func update(addresses: [Location]) {
        var tmpAddresses: [Location] = []
        addresses.unique.forEach { (addLocation) in
            var isAdded = false
            for existedLocation in self {
                if existedLocation == addLocation {
                    isAdded = true
                    break
                }
            }
            if isAdded == false, addLocation.name != ""{
                tmpAddresses.append(addLocation)
            }
        }
        self.append(contentsOf: tmpAddresses)
    }
}
