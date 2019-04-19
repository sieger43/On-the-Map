//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by John Berndt on 4/14/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
    }

    @IBAction func doFindLocation(_ sender: Any) {
        
        var title: String = ""
        var message: String = ""
        
        if locationTextField.text == "" || websiteTextField.text == "" {
            title = "Location Not Found"
            message = "Must Enter a Location"
        } else if let linkText = websiteTextField.text {
            if !linkText.uppercased().starts(with: "HTTPS://") {
                title = "Location Not Found"
                message = "Invalid Link. Include HTTP(S)://"
            }
        }
        
        if title != "" && message != "" {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }

        // this function partly adapted from https://cocoacasts.com/forward-geocoding-with-clgeocoder
        
        let rawLocationText = locationTextField.text;
        let linkText = websiteTextField.text;
        
        var address: String = ""
        var link: String = ""
        var locationText: String = ""

        if let unwrappedString = rawLocationText, let unwrappedLink = linkText,
            let unwrappedLocation = rawLocationText {
            address = unwrappedString
            link = unwrappedLink
            locationText = unwrappedLocation
        }
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print("Unable to Forward Geocode Address (\(error))")
                
            } else {
                
                var rawLocation: CLLocation?
                var location: CLLocation = CLLocation(latitude: 0, longitude: 0)
                var foundLocation: Bool = false

                if let placemarks = placemarks, placemarks.count > 0 {
                    rawLocation = placemarks.first?.location
                }
                
                if let rawLocation = rawLocation {
                    location = rawLocation
                    foundLocation = true
                } else {
                    // locationLabel.text = "No Matching Location Found"
                }
                
                if foundLocation {
                    
                    let mapController = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationMapViewController") as! AddLocationMapViewController
                    
                    mapController.location = location
                    mapController.locationText = locationText
                    mapController.linkText = link
                    
                    self.navigationController!.pushViewController(mapController, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}
