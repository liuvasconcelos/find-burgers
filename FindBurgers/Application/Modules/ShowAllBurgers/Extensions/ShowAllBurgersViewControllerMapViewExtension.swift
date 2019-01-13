//
//  ShowAllBurgersViewControllerMapViewExtension.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 13/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

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
        
        
        let imagePath = self.nearVenues[venuesOrder].photo ?? ""
        if let url = NSURL(string: imagePath) {
            if let data = NSData(contentsOf: url as URL) {
                annotationView?.image = UIImage(data: data as Data)?.resizeImage(CGSize(width: 20, height: 20))?.roundedImage()
            }
        }
        
        self.venuesOrder+=1
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleView = MKCircleRenderer(overlay: overlay)
        circleView.strokeColor = UIColor.red
        circleView.lineWidth = 1
        return circleView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let current = venuesOrder - 1
        if let annotationView = view.annotation, let annotationTitle = annotationView.title {
            let controller: BurgerDetailsViewController = ViewUtils.loadNibNamed(BurgerDetailsViewController.NIB_NAME, owner: self)!
            
            if let image = self.nearVenues[current].photo {
                if String(annotationTitle ?? "") != "My Location" {
                    controller.set(title: String(annotationTitle ?? ""), photo: image)
                    self.present(controller, animated: true, completion: nil)
                }
                
            }
            
        }
    }
    
}

