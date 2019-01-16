//
//  FoursquareApiDataSource.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation

protocol FoursquareApiDataSource {
    func findBurgersNear(latitude: Double, longitude: Double, _ loadCallback: @escaping (BaseCallback<[VenueResponse]>) -> Void)
    func searchForPhotosOfAVenueBy(id: String, _ loadCallback: @escaping (BaseCallback<[PhotoResponse]>) -> Void)
}
