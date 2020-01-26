//
//  MapViewController.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 1/16/20.
//  Copyright © 2020 Do Thai Bao. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var stateController: StateController?
    
    private let locationManager = CLLocationManager()
    
    var userLat: CLLocationDegrees = 20.0
    var userLon: CLLocationDegrees = 20.0
    var currentAddress: String?
    
    let googleApiKey = "AIzaSyDskFtKfxUL2SXmS6zGtYO7AW7BKhDTfK0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.searchButton.layer.cornerRadius = 10.0
        self.confirmButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func showAutocompleteScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "Show Autocomplete", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Autocomplete" {
            if let autocompleteVC = segue.destination as? AutocompleteViewController {
                if let stateController = stateController {
                    var size = stateController.addresses.size
                    for index in 0..<size {
                        autocompleteVC.savedAddress[index] = stateController.addresses[size-index-1]
                    }
                    size = stateController.recently.size
                    for index in 0..<size {
                        autocompleteVC.recentlyAddress[index] = stateController.recently[size-index-1]
                    }
                }
                autocompleteVC.delegate = self
                autocompleteVC.updateAddressLocationClosure = { [weak self] text in
                    self?.currentAddress = text
                }
                autocompleteVC.userLat = userLat
                autocompleteVC.userLon = userLon
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if let address = currentAddress {
            moveToNew(address: address)
        }
    }
    func moveToNew(address: String) {
        guard let correctedAddress = address.addingPercentEncoding(withAllowedCharacters: .symbols) else {
            print("Error. cannot cast name into String")
            return
        }
        
        let urlString =  "https://maps.googleapis.com/maps/api/geocode/json?address=\(correctedAddress)&sensor=false&key=\(self.googleApiKey)"
        let url = URL(string: urlString)
        
        Alamofire.request(url!, method: .get, headers: nil)
        .validate()
            .responseJSON { (response) in
                switch response.result {
                case.success(let value):
                    let json = JSON(value)
                    let lat = json["results"][0]["geometry"]["location"]["lat"].rawString()
                    let lon = json["results"][0]["geometry"]["location"]["lng"].rawString()
                    let formattedAddress = json["results"][0]["formatted_address"].rawString()
                    if let lat = lat, let lon = lon, let address = formattedAddress {
                        DispatchQueue.main.async {
                            let latDouble = Double(lat)
                            let lonDouble = Double(lon)
                            self.mapView.clear()
                            let position = CLLocationCoordinate2D(latitude: latDouble ?? 20.0, longitude: lonDouble ?? 10.0)
                            let marker = GMSMarker(position: position)
                            let camera = GMSCameraPosition.camera(withLatitude: latDouble ?? 20.0, longitude: lonDouble ?? 10.0, zoom: 15)
                            self.mapView.camera = camera
                            marker.title = address
                            marker.map = self.mapView
                            self.mapView.selectedMarker = marker
                        }
                    }
                case.failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = false
        
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        let position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        userLat = location.coordinate.latitude
        userLon = location.coordinate.longitude
        let marker = GMSMarker(position: position)
        mapView.selectedMarker = marker
        marker.title = "User's location"
        marker.map = mapView
        locationManager.stopUpdatingLocation()
    }
}
extension MapViewController: AutocompleteViewControllerDelegate {
    func update(savedAddress: [Location], recentAddress: [Location]) {
        stateController?.update(recentAddress: savedAddress)
        stateController?.update(savedAddress: recentAddress)
    }
}
