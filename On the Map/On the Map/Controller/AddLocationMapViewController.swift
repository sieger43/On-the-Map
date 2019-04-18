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
    
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchLocationAnnotationstoMap()
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        
        title = "Add Location"
    }
    
    func addSearchLocationAnnotationstoMap(){
        
        if let loc = location {

            let lat = loc.coordinate.latitude;
            let lon = loc.coordinate.longitude;

            let mapAnnotation = MKPointAnnotation()
            
            mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            self.mapView.addAnnotation(mapAnnotation)
            
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
}
