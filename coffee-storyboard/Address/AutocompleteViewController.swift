//
//  AucompleteTableViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/17/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import GoogleMaps

protocol AutocompleteViewControllerDelegate: AnyObject {
    func update(savedAddress: [Location], recentAddress: [Location])
}

class AutocompleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate
{
    var userLat: CLLocationDegrees = 20.0
    var userLon: CLLocationDegrees = 20.0
    private var currentRecent = 0
    private var currentSave = 0
    //MARK: Delegate: table view and search textfield
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchTextField()
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.white
    }
    fileprivate func setupSearchTextField() {
        searchTextField.delegate = self
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.cornerRadius = 10.0
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Data model
    var savedAddress = Array(repeating: Location(name: nil), count: 5)
    var recentlyAddress = Array(repeating: Location(name: nil), count: 5)
    // MARK: - Table view

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Địa chỉ đã lưu"
        case 1:
            return "Địa chỉ gần đây"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
            cell.locationLabel.text = savedAddress[indexPath.row].name
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
            cell.locationLabel.text = recentlyAddress[indexPath.row].name
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return savedAddress.size
        }else if section == 1 {
            return recentlyAddress.size
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.setAttributedFont("Roboto-Bold", 16, header.textLabel?.text ?? "")
        }
        
    }
    
    //MARK: Text field delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.text = ""
        tableView.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.isHidden = false
        if let text = searchTextField.text {
            recentlyAddress[currentRecent%5].name = text
            currentRecent += 1
        }
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = searchTextField as? SearchTextField {
            textField.tableView?.isHidden = true
        }
        return true
    }
    
    //MARK: Closure to pass data backward
    var updateAddressLocationClosure: ((String) -> Void)?
    
    @IBAction func save(_ sender: UIButton) {
        if let searchText = searchTextField.text, recentlyAddress[(currentRecent-1)%5].name == searchText {
            updateAddressLocationClosure?(searchText)
            delegate?.update(savedAddress: savedAddress, recentAddress: recentlyAddress)
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: Delegate to pass data backward
    weak var delegate: AutocompleteViewControllerDelegate?
    
}

extension Array where Element == Location {
    var size:Int {
        var size = 0
        for element in self {
            if element.name != "" {
                size+=1
            }
        }
        return size
    }
}
