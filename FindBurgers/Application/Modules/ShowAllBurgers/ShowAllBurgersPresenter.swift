//
//  ShowAllBurgersPresenter.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

class ShowAllBurgersPresenter: ShowAllBurgersPresenterContract {
    
    private let view:      ShowAllBurgersViewContract
    private let getBurger: GetBurger
    
    init(view: ShowAllBurgersViewContract, getBurger: GetBurger) {
        self.view      = view
        self.getBurger = getBurger
    }
    
    func findBurgersNear(latitude: Double, longitude: Double) {
        getBurger.findBurgersNear(latitude: latitude, longitude: longitude) { (callback) in
            callback.onSuccess({ (burgers) in
                self.searchForPhotosOfAVenueBy(burgers)
            })
            callback.onFailed({ (error) in
                print("falha")
            })
        }
    }
    
    func searchForPhotosOfAVenueBy(_ venues: [VenueResponse]) {
//        for venue in venues {
//            getBurger.searchForPhotosOfAVenueBy(id: venue.id!) { (callback) in
//                callback.onSuccess({ (photos) in
//                    self.view.showNear(venue: self.convertResponseToVenuePhotoDto(response: photos, venue: venue))
//                })
//
//                callback.onFailed({ (error) in
//                    print("falha")
//                })
//            }
//        }
        
        for venue in venues {
            if venue.id == "4dd82fb9e4cd37c893bf78c9" {
                getBurger.searchForPhotosOfAVenueBy(id: "4dd82fb9e4cd37c893bf78c9") { (callback) in
                    callback.onSuccess({ (photos) in
                        self.view.showNear(venue: self.convertResponseToVenuePhotoDto(response: photos, venue: venue))
                    })
                    
                    callback.onFailed({ (error) in
                        print("falha")
                    })
                }
            }
        }
        
    }
    
    fileprivate func convertResponseToVenuePhotoDto(response: [PhotoResponse], venue: VenueResponse) -> VenueDto {
        var photoUrl = ""
        if let firstPhoto = response.first {
            photoUrl = "\(firstPhoto.prefix!)\(firstPhoto.width!)x\(firstPhoto.height!)\(firstPhoto.suffix!)"
        }

        //REMOVE LATER
        photoUrl = "https://fastly.4sqi.net/img/general/720x960/27390522_joS6ywLnQ6X1noPRh2Kycs1-XtAAD5XZs5wmH1UamUQ.jpg"
        
        return VenueDto(id: venue.id ?? "",
                        photo: photoUrl,
                        name: venue.name ?? "",
                        latitude: venue.latitude ?? 0,
                        longitude: venue.longitude ?? 0)
    }
}

