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
        //GET FORMATTED CURRENT DATA
        let url = "https://api.foursquare.com/v2/venues/search?ll=\(latitude),\(longitude)&client_id=TGJUV40BUPGJH0ODDBLARJLHSIMHM3SXJ05V0VTAOSBTQZPO&client_secret=0KSE4A3DQ3L2VIIPKHNW4A5J5HFGMVVASENIESQU23VCIZLO&v=20180108"
        
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
}

