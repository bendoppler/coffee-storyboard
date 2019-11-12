//
//  User.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/8/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class User: NSManagedObject
{
    static func saveUserInfo(userId: String, familyName: String, name: String, birthday: Date?, phoneNumber: Int64?, email: String, in context: NSManagedObjectContext) throws -> () {
        let user = User(context: context)
        user.userId = userId
        user.family_name = familyName
        user.name = name
        user.birthday = birthday
        user.phone_number = phoneNumber ?? -1
        user.email = email
        print("Ain\u{2019}t this a beautiful day")
        // Prints "Ain’t this a beautiful day"
    }
}
