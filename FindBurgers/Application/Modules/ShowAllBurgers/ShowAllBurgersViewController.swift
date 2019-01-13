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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var photosCollectionView: ShowBurgersCollectionView!
    
    var locationManager : CLLocationManager!
    var nearVenues: [VenueDto] = []
    var venuesOrder = 0
    
    lazy var presenter: ShowAllBurgersPresenterContract = {
        return ShowAllBurgersPresenter(view: self,
                                       getBurger: InjectionUseCase.provideGetBurger())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.addGradient()

        locationManager                 = CLLocationManager()
        locationManager.delegate        = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter  = 200
        locationManager.requestWhenInUseAuthorization()
        
        map.delegate = self
        
        photosCollectionView.viewContract = self
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
            let region     = MKCoordinateRegion(center: location.coordinate, span: span)
            map.setRegion(region, animated: false)
            
            presenter.findBurgersNear(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            //CHANGE TO ESTONIA METRO COORDINATES
            let coordinate = CLLocationCoordinate2D(latitude:  -9.66629, longitude: -35.7351)
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
    
    func showNear(venue: VenueDto) {
        self.nearVenues.append(venue)
        let coordinate = CLLocationCoordinate2D(latitude:  venue.latitude ?? 0, longitude: venue.longitude ?? 0)
        addAnnotationAtCoordinate(coordinate: coordinate, title: venue.name ?? "")
        self.showPhotos()
    }
    
    func showBurgerDetails(title: String, photo: String) {
        let controller: BurgerDetailsViewController = ViewUtils.loadNibNamed(BurgerDetailsViewController.NIB_NAME, owner: self)!
        controller.set(title: title, photo: photo)
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func showPhotos() {
        self.photosCollectionView.isHidden = false
        self.photosCollectionView.set(burgers: self.nearVenues)
    }
    
}
