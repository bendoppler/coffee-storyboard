//
//  TabBarMenu.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 11/28/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

class TabBarMenu: UIView {

    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    var height: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(menuItems: [TabItem], frame: CGRect, height: CGFloat) {
        self.init(frame: frame)
        self.height = height
        self.layer.backgroundColor = UIColor.white.cgColor
        
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            let itemView = self.createTabItem(of: menuItems[i], i)
            itemView.tag = i
            
            self.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.widthAnchor.constraint(equalToConstant: itemWidth),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor)
            ])
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activate(tab: 0)
    }
    
    func createTabItem(of item: TabItem, _ index: Int) -> UIView{
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true
        itemTitleLabel.font = UIFont(name:"Roboto", size: height * 1/56)
        
        itemIconView.image = item.icon.withRenderingMode(.alwaysTemplate)
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        itemIconView.tintColor = UIColor.black
        
        tabBarItem.layer.backgroundColor = UIColor.white.cgColor
        if(index >= 0 && index <= 2) {
            tabBarItem.addRightBorder(with: UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 0.3), andWidth: 1.0)
        }
        
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: height * 25/896),
            itemIconView.widthAnchor.constraint(equalToConstant: height * 25/896),
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: height * 8/896),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: height * 20/896),
            itemTitleLabel.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor),
            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: height * 4/896),
            itemTitleLabel.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
        ])
        
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        self.deactivate(tab: from)
        self.activate(tab: to)
    }
    
    private func activate(tab: Int) {
        let activeTab = self.subviews[tab]
        var titleLabel = UILabel()
        var itemImage = UIImageView()
        for subview in activeTab.subviews {
            if subview is UILabel{
                titleLabel = subview as! UILabel
            }
            if subview is UIImageView{
                itemImage = subview as! UIImageView
            }
        }
        DispatchQueue.main.async {
            itemImage.tintColor = UIColor(red: 1.0, green: 206/255, blue: 80/255, alpha: 1.0)
            titleLabel.textColor = UIColor(red: 1.0, green: 206/255, blue: 80/255, alpha: 1.0)
            activeTab.setNeedsDisplay()
            activeTab.layoutIfNeeded()
            self.itemTapped?(tab)
        }
        self.activeItem = tab
    }
    
    func deactivate(tab: Int) {
        let inactiveTab = self.subviews[tab]
        var titleLabel = UILabel()
        var itemImage = UIImageView()
        for subview in inactiveTab.subviews {
            if subview is UILabel{
                titleLabel = subview as! UILabel
            }
            if subview is UIImageView{
                itemImage = subview as! UIImageView
            }
        }
        DispatchQueue.main.async {
            itemImage.tintColor = UIColor.black
            titleLabel.textColor = UIColor.black
            inactiveTab.setNeedsDisplay()
            inactiveTab.layoutIfNeeded()
        }
    }
}

extension UIView {
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        border.layer.shadowPath = UIBezierPath(rect: border.bounds).cgPath
        border.layer.shouldRasterize = true
        border.layer.rasterizationScale = UIScreen.main.scale
        addSubview(border)
    }
}
