//
//  Utilities.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 12/11/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class Utilities {
    static func getUserInfo(userId: String, container: NSPersistentContainer?) -> User? {
        if let context = container?.viewContext {
            return try? User.retrieveUserInfo(userId: userId, in: context)
        }
        return nil
    }
    
    static func getAddresses(container: NSPersistentContainer?) -> [Address]? {
        if let context = container?.viewContext {
            return try? Address.retrieveAddresses(in: context)
        }
        return nil
    }
    static func getRecentAddresses(container: NSPersistentContainer?) -> [RecentAddress]? {
        if let context = container?.viewContext {
            return try? RecentAddress.retrieveAddresses(in: context)
        }
        return nil
    }
}
