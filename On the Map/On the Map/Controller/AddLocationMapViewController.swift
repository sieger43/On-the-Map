//
//  AddLocationMapViewController.swift
//  On the Map
//
//  Created by John Berndt on 4/14/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        
        title = "Add Location"
    }
    
}
