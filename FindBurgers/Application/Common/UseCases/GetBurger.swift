//
//  GetBurger.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation

class GetBurger {
    private let apiDataSource: FoursquareApiDataSource
    
    init(apiDataSource: FoursquareApiDataSource) {
        self.apiDataSource = apiDataSource
    }
    
    func findBurgersNear(latitude: Double, longitude: Double, _ loadCallback: @escaping (BaseCallback<[VenueResponse]>) -> Void) {
        apiDataSource.findBurgersNear(latitude: latitude, longitude: longitude, loadCallback)
    }
    
    func searchForPhotosOfAVenueBy(id: String, _ loadCallback: @escaping (BaseCallback<[PhotoResponse]>) -> Void) {
        apiDataSource.searchForPhotosOfAVenueBy(id: id, loadCallback)
    }
    
}
