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
    var locationText: String?
    var linkText: String?
    var lastObjectID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchLocationAnnotationstoMap()
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        
        title = "Add Location"
    }
    
    func handleUpdateResponse(success: Bool, error: Error?)
    {
        if success {
            
            DispatchQueue.main.async(execute: {
                self.navigationController?.dismiss(animated: true, completion: nil)
            })
            
        } else {
            
            let message = error?.localizedDescription ?? ""
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
    }
    
    func handleDataResponse(success: Bool, error: Error?, objectID: String) {
        if success {
            
            if StudentInformationModel.lastObjectID != "" {
                StudentInformationModel.lastObjectID = objectID
            }
            
            DispatchQueue.main.async(execute: {
                self.navigationController?.dismiss(animated: true, completion: nil)
            })

        } else {
            
            let message = error?.localizedDescription ?? ""
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
    }
    
    @IBAction func doFinish(_ sender: Any) {
    
        if let loc = location, let locText = locationText, let link = linkText {
        
            if let objectID = StudentInformationModel.lastObjectID {
                ParseClient.putStudentLocation(objectId: objectID,
                                                uniqueKey: "0987654321", firstName: "Martin", lastName: "Bishop",
                                                mapString: locText, mediaURL: link,
                                                latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude,
                                                completion: handleUpdateResponse)
            } else {
                ParseClient.postStudentLocation(uniqueKey: "0987654321", firstName: "Martin", lastName: "Bishop",
                                                mapString: locText, mediaURL: link,
                                                latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude,
                                                completion: handleDataResponse)
            }
        }

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
