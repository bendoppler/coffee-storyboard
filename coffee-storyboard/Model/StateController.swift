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

struct Location{
    var name: String
    init(name: String? = nil) {
        self.name = name ?? ""
    }
}

class StateController {
    var user: UserModel = UserModel()
    var addresses: [Location] = []
    var recently: [Location] = []
    
    func update(userInfo: UserModel) {
        user.name = userInfo.name
        user.familyName = userInfo.familyName
        user.birthday = userInfo.birthday
        user.phoneNumber = userInfo.phoneNumber
        user.email = userInfo.email
        user.image = userInfo.image
    }
    
    func update(recentAddress: [Location]) {
        recently.append(contentsOf: recentAddress)
    }
    
    func update(savedAddress: [Location]) {
        addresses.append(contentsOf: savedAddress)
    }
}
