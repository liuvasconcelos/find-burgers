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
    
    var locationManager : CLLocationManager!
    var currentLocationDidNotSet = true

    @IBOutlet weak var map: MKMapView!
    
}
