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

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        ParseClient.getStudentLocations(){ success, error, response in
            if success {
                if let thedata = response {
                    StudentInformationModel.locations = thedata.results
                    
                    DispatchQueue.main.async {
                        self.addStudentLocationAnnotationstoMap()
                    }
                }
                
            } else {
                let errMessage = error?.localizedDescription ?? ""
               
                let alert = UIAlertController(title: "", message: errMessage, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

            }
        }
    }

    func addStudentLocationAnnotationstoMap(){
        
        for loc in StudentInformationModel.locations {
            //print("\(loc)")
            if let lat = loc.latitude, let lon = loc.longitude,
                let firstname = loc.firstName,
                let lastname = loc.lastName,
                let url = loc.mediaURL {

                let mapAnnotation = MKPointAnnotation()
                
                mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                mapAnnotation.title = firstname + " " + lastname
                mapAnnotation.subtitle = url
                
                mapView.addAnnotation(mapAnnotation)
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    // adapted from https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        let identifier = "marker"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
