//
//  SearchTextField.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/17/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

class SearchTextField: UITextField {

    var dataList: [String] = []
    var tableView: UITableView?
    let apiKey = "AIzaSyAAb36Nai82Pg1gWKkLjviPuFqne1eG77Q"
    var userLat: CLLocationDegrees = 20.0
    var userLon: CLLocationDegrees = 20.0
    var location = Location(name: nil)
    
    // Connecting the new element to the parent view
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
        
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
        
    }
    
    
    //////////////////////////////////////////////////////////////////////////////
    // Text Field related methods
    //////////////////////////////////////////////////////////////////////////////
    
    @objc open func textFieldDidChange(){
        print("Text changed ...")
        filter()
        updateSearchTableView()
        tableView?.isHidden = false
    }
    
    @objc open func textFieldDidBeginEditing() {
        print("Begin Editing")
    }
    
    @objc open func textFieldDidEndEditing() {
        print("End editing")

    }
    
    @objc open func textFieldDidEndEditingOnExit() {
        print("End on Exit")
    }
    
    func filter() {
        if let text = self.text {
            let filter = GMSAutocompleteFilter()
            let placesClient = GMSPlacesClient()
            filter.type = .establishment
            let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: userLat - 1 < -90 ? -90 : userLat-1, longitude: userLon - 2 < -180 ? -180 : userLon - 2), coordinate: CLLocationCoordinate2D(latitude: userLat + 1 > 90 ? 90 : userLat+1, longitude: userLon + 2 > 180 ? 180 : userLon + 2))
           
            placesClient.autocompleteQuery(text, bounds: bounds, filter: nil) { [weak self] (results, error) in
                self?.dataList.removeAll()
                if let error = error {
                    print("Autocomplete error \(error)")
                    return
                }
                if let results = results {
                    for result in results {
                       self?.dataList.append(result.attributedFullText.string)
                    }
                }
                self?.tableView?.reloadData()
           }
        }
    }
    
    //MARK: Inset edge
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
}

extension SearchTextField: UITableViewDelegate, UITableViewDataSource {
    
    // Create SearchTableview
    func buildSearchTableView() {
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchTextFieldCell")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)

        } else {
            //addData()
            print("tableView created")
            tableView = UITableView(frame: CGRect.zero)
        }
        updateSearchTableView()
    }
    
    // Updating SearchtableView
    func updateSearchTableView() {
        if let tableView = tableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height
            
            // Set a bottom margin of 10p
            if tableHeight < tableView.contentSize.height {
                tableHeight -= 10
            }
            
            // Set tableView frame
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = tableViewFrame
            })
            
            //Setting tableView style
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 5.0
            tableView.separatorColor = UIColor.lightGray
            tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTextFieldCell", for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = dataList[indexPath.row]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row")
        self.text = dataList[indexPath.row]
        location.name = dataList[indexPath.row]
        tableView.isHidden = true
        self.endEditing(true)
    }
}
