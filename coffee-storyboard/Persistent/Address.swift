//
//  Address.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/26/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import CoreData

class Address: NSManagedObject
{
    static func saveAddress(name: String, latitude: Double, longitude: Double, in context: NSManagedObjectContext) throws -> (){
        let request: NSFetchRequest<Address> = Address.fetchRequest()
               request.predicate = NSPredicate(format: "name = %@", name)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                print("Address already saved")
            } else {
                if name != "" {
                    let address = Address(context: context)
                    address.name = name
                    address.latitude = latitude
                    address.longitude = longitude
                    do {
                        try context.save()
                        print("saved!")
                    } catch let error as NSError  {
                       print("Could not save \(error), \(error.userInfo)")
                    } catch {
                        throw error
                    }
                }
            }
        } catch {
            throw error
        }
    }
    
    static func retrieveAddresses(in context: NSManagedObjectContext) throws -> [Address]?
    {
        let fetchRequest = NSFetchRequest<Address>(entityName: "Address")
        do {
            let addresses = try context.fetch(fetchRequest)
            return addresses
        }
        catch {
            print(error)
            return nil
        }
    }
    
    static func deleteAddress(name: String, in context: NSManagedObjectContext) throws -> () {
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
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
}
