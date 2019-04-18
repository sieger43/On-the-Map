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
        
        // this function partly adapted from https://cocoacasts.com/forward-geocoding-with-clgeocoder
        
        let rawLocation = locationTextField.text;
        var address: String = "";
        
        if let unwrappedString = rawLocation {
            address = unwrappedString;
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
                    
                    self.navigationController!.pushViewController(mapController, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}
