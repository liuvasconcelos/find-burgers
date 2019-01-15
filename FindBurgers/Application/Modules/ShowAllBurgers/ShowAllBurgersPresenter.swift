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
                print("falha")
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
//                    print("falha")
//                })
//            }
//        }
//
        
        
        let urls = ["https://fastly.4sqi.net/img/general/720x960/27390522_joS6ywLnQ6X1noPRh2Kycs1-XtAAD5XZs5wmH1UamUQ.jpg",
                    "https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000nvq8uMAA/5702ad59e4b003b478eb4d56.jpg&w=620&h=400",
                    "https://http2.mlstatic.com/carrinho-de-lanche-com-chapa-bifeteira-e-vidro-inox-r2-D_NQ_NP_732414-MLB25580705633_052017-F.jpg"]
        
        self.lookOnlyForBurgers(urls: urls, venue: venues.first!)
    }
    
    fileprivate func lookOnlyForBurgers(urls: [String], venue: VenueResponse) {
        getImage.lookForBurguersBy(venuesPhotosUrl: urls) { (callback) in
            callback.onSuccess({ (burgerPhoto) in
                self.view.showNear(venue: self.convertResponseToVenuePhotoDto(photo: burgerPhoto, venue: venue))
            })
            
            callback.onFailed({ (error) in
                print("2")
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

