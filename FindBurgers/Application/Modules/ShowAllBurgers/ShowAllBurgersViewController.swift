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

class ShowAllBurgersViewController: UIViewController, ShowAllBurgersViewContract, CLLocationManagerDelegate, HeaderMapDelegate {
   
    public static let NIB_NAME = "ShowAllBurgersViewController"
    
    @IBOutlet weak var photosCollectionView: BurgerCollectionView!
    @IBOutlet weak var coloredBackground: UIView!
    
    var locationManager : CLLocationManager!
    var nearVenues: [VenueDto] = []
    var venuesOrder = 0
    var map: MKMapView?
    
    var currentLocationDidNotSet = true
    
    let tartuBusStationLatitude = 58.3780
    let tartuBusStatiusLongitude = 26.7321
    
    @IBOutlet weak var mainView: UIView!
    var tartuBusStationLocation: CLLocation?
    
    lazy var presenter: ShowAllBurgersPresenterContract = {
        return ShowAllBurgersPresenter(view: self,
                                       getBurger: InjectionUseCase.provideGetBurger(),
                                       getImage: InjectionUseCase.provideGetImage())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.set(headerDelegate: self)
        
        photosCollectionView.viewContract = self
        mainView.addGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.addGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tartuBusStationLocation = CLLocation(latitude: self.tartuBusStationLatitude, longitude: self.tartuBusStatiusLongitude)
    }
    
    func setupMap(map: MKMapView) {
        self.map = map
        locationManager                 = CLLocationManager()
        locationManager.delegate        = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        map.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocationDidNotSet {
            if let location = locations.first {
                let span       = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region     = MKCoordinateRegion(center: location.coordinate, span: span)
                map!.setRegion(region, animated: false)

                presenter.findBurgersNear(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                currentLocationDidNotSet = false
                
                let coordinate = CLLocationCoordinate2D(latitude:  self.tartuBusStationLatitude, longitude: self.tartuBusStatiusLongitude)
                let circleOverlay: MKCircle = MKCircle(center: coordinate, radius: 1000)
                map!.addOverlay(circleOverlay)
            }
        }
        
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        map!.addAnnotation(annotation)
    }
    
    func showNear(venue: VenueDto) {
        self.nearVenues.append(venue)
        let coordinate = CLLocationCoordinate2D(latitude:  venue.latitude ?? 0, longitude: venue.longitude ?? 0)
        let venueLocation = CLLocation(latitude: venue.latitude ?? 0, longitude: venue.longitude ?? 0)
        
        if venueLocation.distance(from: self.tartuBusStationLocation!) > 1000 {
            addAnnotationAtCoordinate(coordinate: coordinate, title: venue.name ?? "")
            self.showPhotos()
        }
        
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
    
    func showError() {
        let alertError = UIAlertController(title: "", message: "An error occured, please reopen app and try again.", preferredStyle: .alert)
        let buttonAction = UIAlertAction(title: "OK", style: .destructive)
        alertError.addAction(buttonAction)
        self.present(alertError, animated: true, completion: nil)
    }
    
}
