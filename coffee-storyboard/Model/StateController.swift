//
//  StateController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 12/31/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import Foundation

struct UserModel {
    var name: String
    var familyName: String
    var birthday: String
    var phoneNumber: String
    var email: String
    init(name: String? = nil, familyName: String? = nil, birthday: String? = nil, phoneNumber: String? = nil, email: String? = nil) {
        self.name = name ?? ""
        self.familyName = familyName ?? ""
        self.birthday = birthday ?? ""
        self.phoneNumber = phoneNumber ?? ""
        self.email = email ?? ""
    }
}

class StateController {
    var user: UserModel = UserModel()
}
