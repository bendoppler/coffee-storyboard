//
//  RecentAddress.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/26/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//


import UIKit
import CoreData

class RecentAddress: NSManagedObject
{
    static func saveAddress(name: String, in context: NSManagedObjectContext) throws -> (){
        let request: NSFetchRequest<RecentAddress> = RecentAddress.fetchRequest()
               request.predicate = NSPredicate(format: "name = %@", name)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                print("Address already saved")
            } else {
                let address = RecentAddress(context: context)
                address.name = name
                do {
                    try context.save()
                    print("saved!")
                } catch let error as NSError  {
                   print("Could not save \(error), \(error.userInfo)")
                } catch {
                    throw error
                }
            }
        } catch {
            throw error
        }
    }
    
    static func retrieveAddresses(in context: NSManagedObjectContext) throws -> [RecentAddress]?
    {
        let fetchRequest = NSFetchRequest<RecentAddress>(entityName: "RecentAddress")
        do {
            let addresses = try context.fetch(fetchRequest)
            return addresses
        }
        catch {
            print(error)
            return nil
        }
    }
}

