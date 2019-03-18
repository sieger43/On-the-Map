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
                print("Happy handleStudentsLocationsResponse")
                
                if let thedata = response {
                    print("\(thedata.results)")
                    StudentModel.locations = response?.results ?? [StudentLocation]()
                    
                    DispatchQueue.main.async {
                        self.addStudentLocationAnnotationstoMap()
                    }
                }
                
            } else {
                let message = error?.localizedDescription ?? ""
                print("\(message)");
                print("Sad handleStudentsLocationsResponse")
            }
        }
    }

    func addStudentLocationAnnotationstoMap(){
        
        for loc in StudentModel.locations {
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
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
