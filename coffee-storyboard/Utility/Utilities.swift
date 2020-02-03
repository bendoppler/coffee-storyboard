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
    
    static func loadData() -> [Category]{
        let signature = [
            Food(image: UIImage(named: "food_sample_image")!, name: "Cà phê sữa", size: "Size nhỏ (240 ml)", price: 18000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Cà phê sữa", size: "Size vừa (350 ml)", price: 25000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Cà phê sữa", size: "Size lớn (400 ml)", price: 39000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Cookies and creams", size: "Một size duy nhất", price: 55000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Machiato", size: "Size vừa (350 ml)", price: 25000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Trà sữa chân trâu hoàn châu cách cách", size: "Size vừa (350 ml)", price: 35000)
        ]
        let coffees = [
            Food(image: UIImage(named: "food_sample_image")!, name: "Coldbrew hoa hồng", size: "Một size duy nhất", price: 50000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Coldbrew sữa tươi", size: "Một size duy nhất", price: 50000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Coldbrew truyền thống", size: "Một size duy nhất", price: 45000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Cà phê sữa", size: "Size nhỏ (240 ml)", price: 18000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Cà phê sữa", size: "Size vừa (350 ml)", price: 25000)
        ]
        let milktea = [
            Food(image: UIImage(named: "food_sample_image")!, name: "Trà cherry macchiato", size: "Một size duy nhất", price: 50000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Matcha macchiato", size: "Một size duy nhất", price: 50000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Trà đen macchiato", size: "Một size duy nhất", price: 50000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Trà xoài macchiato", size: "Một size duy nhất", price: 50000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Trà bưởi mật ong", size: "Một size duy nhất", price: 50000),
        ]
        let cookies = [
            Food(image: UIImage(named: "food_sample_image")!, name: "Cookies đá xay", size: "Một size duy nhất", price: 59000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Chocolate đá xay", size: "Một size duy nhất", price: 59000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Chanh xả đá xay", size: "Một size duy nhất", price: 49000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Đào việt quất đá xay", size: "Một size duy nhất", price: 59000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Phúc bồn tử cam đá xay", size: "Một size duy nhất", price: 59000),
        ]
        let cakes = [
            Food(image: UIImage(named: "food_sample_image")!, name: "Bánh bông lan trứng muối", size: "Một size duy nhất", price: 29000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Bánh chocolate", size: "Một size duy nhất", price: 29000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Bánh croissant bơ tỏi", size: "Một size duy nhất", price: 29000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Bánh matcha", size: "Một size duy nhất", price: 29000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Bánh mì chà bông phô mai", size: "Một size duy nhất", price: 29000),
            Food(image: UIImage(named: "food_sample_image")!, name: "Bánh tiramisu", size: "Một size duy nhất", price: 29000),
        ]
        let categories = [
            Category(name: "Nổi bật", foods: signature),
            Category(name: "Cà phê", foods: coffees),
            Category(name: "Trà sữa", foods: milktea),
            Category(name: "Đá xay", foods: cookies),
            Category(name: "Bánh", foods: cakes)
        ]
        return categories
    }
}
