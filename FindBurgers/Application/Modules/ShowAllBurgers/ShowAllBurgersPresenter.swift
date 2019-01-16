//
//  ShowAllBurgersPresenter.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit

class ShowAllBurgersPresenter: ShowAllBurgersPresenterContract {
    
    private let view:      ShowAllBurgersViewContract
    private let getBurger: GetBurger
    private let getImage:  GetImage
    
    init(view: ShowAllBurgersViewContract, getBurger: GetBurger, getImage: GetImage) {
        self.view      = view
        self.getBurger = getBurger
        self.getImage  = getImage
    }
    
    func findBurgersNear(latitude: Double, longitude: Double) {
        getBurger.findBurgersNear(latitude: latitude, longitude: longitude) { (callback) in
            callback.onSuccess({ (burgers) in
                self.searchForPhotosOfAVenueBy(burgers)
            })
            callback.onFailed({ (error) in
                self.view.showError()
            })
        }
    }
    
    func searchForPhotosOfAVenueBy(_ venues: [VenueResponse]) {
//        for venue in venues {
//            getBurger.searchForPhotosOfAVenueBy(id: venue.id!) { (callback) in
//                callback.onSuccess({ (photos) in
//                    self.lookOnlyForBurgers(urls: self.buildPhotosUrl(response: photos), venue: venue)
//                })
//
//                callback.onFailed({ (error) in
//                    self.view.showError()
//                })
//            }
//        }
//
        var index = 1
        
        for venue in venues {
            if index < 9 {
                let urls = ["https://fastly.4sqi.net/img/general/720x540/zy_kqh6KcchiJf9Cf_gMKMU4PQIta8ajtkUzjFv9eiI.jpg",
                            "https://fastly.4sqi.net/img/general/1440x1920/51988053__6lLEAwG0BqqHZY5UUY_bI4RK-ieYEPI8jD3IqZ3Jq0.jpg",
                            "https://fastly.4sqi.net/img/general/960x720/36549713_pXpsBMAaAApl0z6yC7F3weYHsVl9xrz-dooCGk9Lbm0.jpg"]
                
                self.lookOnlyForBurgers(urls: urls, venue: venue)
            }
            index+=1
        }
        
        
    }
    
    fileprivate func lookOnlyForBurgers(urls: [String], venue: VenueResponse) {
        getImage.lookForBurguersBy(venuesPhotosUrl: urls) { (callback) in
            callback.onSuccess({ (burgerPhoto) in
                self.view.showNear(venue: self.convertResponseToVenuePhotoDto(photo: burgerPhoto, venue: venue))
            })
        }
    }
    
    fileprivate func buildPhotosUrl(response: [PhotoResponse]) -> [String] {
        var photos: [String] = []
        for photo in response {
            photos.append("\(photo.prefix!)\(photo.width!)x\(photo.height!)\(photo.suffix!)")
        }
        
        return photos
    }
    
    fileprivate func convertResponseToVenuePhotoDto(photo: BurgerPhotoResponse, venue: VenueResponse) -> VenueDto {
       
        return VenueDto(id: venue.id ?? "",
                        photo: photo.urlWithBurger ?? "",
                        name: venue.name ?? "",
                        latitude: venue.latitude ?? 0,
                        longitude: venue.longitude ?? 0)
    }
}

