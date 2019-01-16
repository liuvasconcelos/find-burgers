//
//  FoursquareApiDataSourceImpl.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class FoursquareApiDataSourceImpl: FoursquareApiDataSource {
    
    private static var INSTANCE: FoursquareApiDataSourceImpl?
    var currentDate = ""
    
    public static func getInstance() -> FoursquareApiDataSourceImpl {
        if (INSTANCE == nil) {
            INSTANCE = FoursquareApiDataSourceImpl()
        }
        
        return INSTANCE!
    }
    
    public static func destroyInstance() {
        INSTANCE = nil
    }
    
    func findBurgersNear(latitude: Double, longitude: Double, _ loadCallback: @escaping (BaseCallback<[VenueResponse]>) -> Void) {
        self.getDate()
        let url = "https://api.foursquare.com/v2/venues/search?ll=\(latitude),\(longitude)&client_id=TGJUV40BUPGJH0ODDBLARJLHSIMHM3SXJ05V0VTAOSBTQZPO&client_secret=0KSE4A3DQ3L2VIIPKHNW4A5J5HFGMVVASENIESQU23VCIZLO&v=\(self.currentDate)"
        
        Alamofire.request(url, method: .get).responseObject {
            (response: DataResponse<BaseVenueResponse>) in
            switch(response.result) {
            case .success(let response):
                guard let venues = response.response else{ return }
                loadCallback(BaseCallback.success(venues))
                break
            case .failure(let error):
                loadCallback(BaseCallback.failed(error: error))
                break
            }
        }
        
    }
    
    func searchForPhotosOfAVenueBy(id: String, _ loadCallback: @escaping (BaseCallback<[PhotoResponse]>) -> Void) {
        let url = "https://api.foursquare.com/v2/venues/\(id)/photos?&client_id=TGJUV40BUPGJH0ODDBLARJLHSIMHM3SXJ05V0VTAOSBTQZPO&client_secret=0KSE4A3DQ3L2VIIPKHNW4A5J5HFGMVVASENIESQU23VCIZLO&v=\(self.currentDate)"

        Alamofire.request(url, method: .get).responseObject {
            (response: DataResponse<BasePhotoResponse>) in
            switch(response.result) {
            case .success(let response):
                if let venues = response.photos {
                    loadCallback(BaseCallback.success(venues))
                } else {
                    loadCallback(BaseCallback.success([]))
                }

                break
            case .failure(let error):
                loadCallback(BaseCallback.failed(error: error))
                break
            }
        }
        
    }
    
    fileprivate func getDate() {
        let date = Date()
        let calendar = Calendar.current
        
        let year  = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day   = calendar.component(.day, from: date)
        
        var formattedMonth = String(month)
        if month < 10 { formattedMonth = "0\(month)" }
        
        var formattedDay = String(day)
        if day < 10 { formattedDay = "0\(day)"}
        
        self.currentDate = "\(year)\(formattedMonth)\(formattedDay)"
    }
    
}

