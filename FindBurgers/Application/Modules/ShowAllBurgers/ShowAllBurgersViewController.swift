//
//  ShowAllBurgersViewController.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShowAllBurgersViewController: UIViewController, ShowAllBurgersViewContract, CLLocationManagerDelegate, MKMapViewDelegate {
    
    public static let NIB_NAME = "ShowAllBurgersViewController"
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager                 = CLLocationManager()
        locationManager.delegate        = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter  = 200
        locationManager.requestWhenInUseAuthorization()
        
        let coordinate = CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.4167)
        let circleOverlay: MKCircle = MKCircle(center: coordinate, radius: 1000)
        mapView.addOverlay(circleOverlay)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span   = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: false)
            addAnnotationAtCoordinate(coordinate: location.coordinate)
        }
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "An annotation!"
        mapView.addAnnotation(annotation)
    }
    
//    func addAnnotationAtAddress(address: String, title: String) {
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(address) { (placemarks, error) in
//            if let placemarks = placemarks {
//                if placemarks.count != 0 {
//                    let coordinate = placemarks.first!.location!
//                    let annotation = MKPointAnnotation()
//                    annotation.coordinate = coordinate.coordinate
//                    annotation.title = title
//                    self.mapView.addAnnotation(annotation)
//                }
//            }
//        }
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customAnnotationView"
        
        // custom image annotation
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        else {
            annotationView!.annotation = annotation
        }
        annotationView!.image = UIImage(named: "liu")
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let circleView = MKCircleRenderer(overlay: overlay)
        circleView.strokeColor = UIColor.red
        circleView.lineWidth = 1
        return circleView
    }
    
}
