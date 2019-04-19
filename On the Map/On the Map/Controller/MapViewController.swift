//
//  MapViewController.swift
//  On the Map
//
//  Created by John Berndt on 3/13/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        refreshMapPins(self)
    }

    @IBAction func doLogout(_ sender: Any) {
        UdacityClient.logout(completion: handleLogoutResponse)
    }

    func handleLogoutResponse() {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func refreshMapPins(_ sender: Any) {
        
        ParseClient.getStudentLocations(){ success, error, response in
            if success {
                if let thedata = response {

                    self.mapView.removeAnnotations(self.mapView.annotations)

                    StudentInformationModel.locations = thedata.results
                    
                    StudentInformationModel.sort()
                    
                    self.addStudentLocationAnnotationstoMap()
                }
                
            } else {
                let errMessage = error?.localizedDescription ?? ""
                
                let alert = UIAlertController(title: "", message: errMessage, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
            }
        }
        
    }
    
    func addStudentLocationAnnotationstoMap(){
        
        for loc in StudentInformationModel.locations {
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
            view.rightCalloutAccessoryView?.isHidden = true
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        view.addGestureRecognizer(gesture)
    }
    
    func mapView(_ mapView: MKMapView,
                 didDeselect view: MKAnnotationView) {
        for recognizer in view.gestureRecognizers ?? [] {
            view.removeGestureRecognizer(recognizer)
        }
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {

        if self.mapView.selectedAnnotations.count > 0 {
            
            let annotation = self.mapView.selectedAnnotations[0]
            
            if let rawstring = annotation.subtitle, let urlstring = rawstring,
                let url = URL(string: urlstring) {
                    UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
