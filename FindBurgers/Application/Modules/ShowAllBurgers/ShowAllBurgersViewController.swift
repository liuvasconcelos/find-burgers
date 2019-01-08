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

class ShowAllBurgersViewController: UIViewController, ShowAllBurgersViewContract, CLLocationManagerDelegate {
    
    public static let NIB_NAME = "ShowAllBurgersViewController"
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager                 = CLLocationManager()
        locationManager.delegate        = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter  = 200
        locationManager.requestWhenInUseAuthorization()
        
        map.delegate = self
        
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
            let span       = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let coordinate = CLLocationCoordinate2D(latitude:  -9.66629, longitude: -35.7351)
            let region     = MKCoordinateRegion(center: location.coordinate, span: span)
            map.setRegion(region, animated: false)
            
            addAnnotationAtCoordinate(coordinate: coordinate, title: "Teste")
            addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D(latitude: -9.648587, longitude:  -35.712260), title: "Tiago")

            let circleOverlay: MKCircle = MKCircle(center: coordinate, radius: 1000)
            map.addOverlay(circleOverlay)
        }
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        map.addAnnotation(annotation)
    }
    
}

extension ShowAllBurgersViewController: MKMapViewDelegate {
    func mapView (_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        if annotation.title == "Tiago"{
            let pinImage = UIImage(named: "tiago")?.resizeImage(CGSize(width: 20, height: 20))?.roundedImage()
            annotationView!.image = pinImage
        } else {
            let pinImage = UIImage(named: "test1")?.resizeImage(CGSize(width: 20, height: 20))
            annotationView!.image = pinImage
        }
        
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleView = MKCircleRenderer(overlay: overlay)
        circleView.strokeColor = UIColor.red
        circleView.lineWidth = 1
        return circleView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title!! as Any)
    }
}
