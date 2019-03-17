//
//  MapViewController.swift
//  On the Map
//
//  Created by John Berndt on 3/13/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ParseClient.getStudentLocations(){ success, error, response in
            if success {
                print("Happy handleStudentsLocationsResponse")
                
                if let thedata = response {
                    print("\(thedata.results)")
                }
                
            } else {
                let message = error?.localizedDescription ?? ""
                print("\(message)");
                print("Sad handleStudentsLocationsResponse")
            }
        }
    }


}
