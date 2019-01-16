//
//  HeaderView.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 15/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HeaderView: UICollectionReusableView, CLLocationManagerDelegate {
    
    public static let NIB_NAME   = "HeaderView"
    public static let IDENTIFIER = "HeaderViewIdentifier"
    
    var mapDelegate: HeaderMapDelegate?

    @IBOutlet weak var map: MKMapView!
    
    func configureView() {
        mapDelegate?.setupMap(map: self.map)
    }
    
}

protocol HeaderMapDelegate: class {
    func setupMap(map: MKMapView)
}
