//
//  FoodOrderViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 2/4/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import MBRadioCheckboxButton

class FoodOrderViewController: UIViewController
{
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var sizeViewGroup: RadioButtonContainerView!
    @IBOutlet weak var checkBoxButton: CheckboxButton! {
        didSet {
            checkBoxButton.delegate = self
        }
    }
    @IBOutlet weak var foodImageView: UIImageView! {
        didSet {
            if let food = food {
                foodImageView.image = food.image
            }
        }
    }
    @IBOutlet weak var foodNameLabel: UILabel! {
        didSet {
            if let food = food {
                foodNameLabel.text = food.name
            }
        }
    }
    @IBOutlet weak var foodDescription: UILabel!{
        didSet {
            if let food = food {
                foodDescription.text = food.description
            }
        }
    }
    @IBOutlet weak var sizeSPriceLabel: UILabel! {
        didSet {
            if let food = food {
                sizeSPriceLabel.text = food.price.convertToCurrency() + " vnđ"
            }
        }
    }
    @IBOutlet weak var sizeMPriceLabel: UILabel! {
        didSet {
            if let food = food {
                sizeMPriceLabel.text = (food.price + 6000).convertToCurrency() + " vnđ"
            }
        }
    }
    @IBOutlet weak var sizeLPriceLabel: UILabel! {
        didSet {
            if let food = food {
                sizeLPriceLabel.text = (food.price + 12000).convertToCurrency() + " vnđ"
            }
        }
    }
    @IBOutlet weak var doubleShotLabel: UILabel! {
        didSet {
            doubleShotLabel.text = "+ " + doubleShot.convertToCurrency() + " vnđ"
        }
    }
    
    @IBOutlet weak var foodCntLabel: UILabel!
    @IBOutlet weak var plusButton: ButtonView!
    @IBOutlet weak var minusButton: ButtonView!
    
    var food: Food?
    var doubleShot: Int64 = 10000
    var price: Int64 = 0 {
        didSet {
            if price == 0 {
                orderButton.setTitle("BỎ CHỌN MÓN", for: .normal)
            }else {
                orderButton.setTitle(price.convertToCurrency() + " vnđ", for: .normal)
            }
        }
    }
    
    var foodPrice: Int64 = 0 {
        didSet {
            if(foodCnt > 0) {
                price = foodPrice * foodCnt
            }
        }
    }
    
    var foodCnt: Int64 = 1  {
       didSet {
           foodCntLabel.text = String(foodCnt)
       }
   }
    var order: Order?
    override func viewDidLoad() {
        super.viewDidLoad()
        orderButton.layer.cornerRadius = 8.0
        setupViewGroup()
        checkBoxButton.checkBoxColor = CheckBoxColor(activeColor: UIColor(red: 1, green: 188/255, blue: 80/255, alpha: 1.0), inactiveColor: UIColor.clear, inactiveBorderColor: checkBoxButton.tintColor, checkMarkColor: UIColor.white)
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.increment(_:)))
        plusButton.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.decrement(_:)))
        minusButton.addGestureRecognizer(gesture2)
    }
    
    @objc func increment(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            foodCnt += 1
            price = foodPrice * foodCnt
        }
    }
    
    @objc func decrement(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if foodCnt > 0 {
                foodCnt -= 1
            }
            price = foodPrice * foodCnt
        }
    }
    
    @IBOutlet weak var sizeSButton: RadioButton!
    private func setupViewGroup() {
        sizeViewGroup.buttonContainer.delegate = self
        sizeViewGroup.buttonContainer.selectedButtons = [sizeSButton]
        sizeViewGroup.buttonContainer.setEachRadioButtonColor {_ in
            return RadioButtonColor(active:UIColor(red: 1, green: 188/255, blue: 80/255, alpha: 1.0), inactive: UIColor.lightGray)
        }
    }
    
    //MARK: Closure
    var updateOrderClosure: ((Order) -> Void)?
    
    @IBAction func pickFood(_ sender: Any) {
        if foodCnt > 0 {
            if var food = food {
                food.price = price
                if var order = order {
                    order.foods.append(food)
                    updateOrderClosure?(order)
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension FoodOrderViewController: RadioButtonDelegate {
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Deselect: ", button.title(for: .normal)!)
    }
    
    
    func radioButtonDidSelect(_ button: RadioButton) {
        print("Select: ", button.title(for: .normal)!)
        if let food = food {
            switch button.titleLabel?.text {
            case "Size S":
                foodPrice = food.price
                break
            case "Size M":
                foodPrice = food.price + 6000
                break
            case "Size L":
                foodPrice = food.price + 12000
                break
            default:
                foodPrice = 0
            }
        }
    }
}

extension FoodOrderViewController: CheckboxButtonDelegate {
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        if foodCnt > 0 {
            price += doubleShot
        }
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
        if foodCnt > 0 {
            price -= doubleShot
        }
    }
}
