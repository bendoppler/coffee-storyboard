//
//  PaymentFoodItemCollectionViewCell.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 4/23/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit

class PaymentFoodItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infoView: InfoView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var plusButtonView: ButtonView!
    @IBOutlet weak var minusButtonView: ButtonView!
    @IBOutlet weak var foodCntLabel: UILabel!
}
