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
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %@", userId)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "User.retrieveUserInfo -- database inconsistency")
            } else {
                let user = User(context: context)
                user.userId = userId
                user.family_name = familyName
                user.name = name
                user.birthday = birthday
                user.phone_number = phoneNumber ?? 0
                user.email = email
            }
        } catch {
            throw error
        }
        try? User.deleteOldUsers(userId: userId, in: context)
    }
    
    static func deleteOldUsers(userId: String, in context: NSManagedObjectContext) throws -> (){
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "userId != %@", userId)
        do {
            let matches = try context.fetch(request)
            for match in matches {
                context.delete(match)
            }
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
               print("Could not save \(error), \(error.userInfo)")
            } catch {
                throw error
            }
        } catch {
            throw error
        }
    }
    
    static func retrieveUserInfo(userId: String, in context: NSManagedObjectContext) throws -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %@", userId)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "User.retrieveUserInfo -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        return nil
    }
}
