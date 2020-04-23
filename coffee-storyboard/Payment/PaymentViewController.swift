//
//  PaymentViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 4/23/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    var order: Order?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Food collection view
    @IBOutlet weak var foodCollectionView: UICollectionView! {
        didSet {
            foodCollectionView.delegate = self
            foodCollectionView.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let order = order {
            return order.foods.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemCell", for: indexPath)
        if let foodCell = cell as? PaymentFoodItemCollectionViewCell, let order = order {
            print(foodCell.bounds)
            print(foodCell.infoView.frame)
            foodCell.infoView.layer.cornerRadius = 3.0
            foodCell.infoView.drawShadow(opacity: 0.5, color: UIColor.lightGray.cgColor)
            foodCell.nameLabel.text = order.foods[indexPath.item].food.name
            foodCell.sizeLabel.text = order.foods[indexPath.item].food.size
            foodCell.priceLabel.text = order.foods[indexPath.item].food.price.convertToCurrency() + " vnđ"
            foodCell.foodCntLabel.text = String(order.foods[indexPath.item].cnt)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let height = collectionView.frame.height
        print(width)
        print(height)
        return CGSize(width: width/2, height: height+20)
    }
    
}
