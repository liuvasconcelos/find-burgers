//
//  VenueResponse.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 08/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation
import ObjectMapper

public class VenueResponse: Mappable {
    var id: String?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var distance: Double?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id          <- map[APIFields.id]
        name        <- map[APIFields.name]
        latitude    <- map[APIFields.latitude]
        longitude   <- map[APIFields.longitude]
        distance    <- map[APIFields.distance]
        
    }
    
    private struct APIFields {
        static let id          = "id"
        static let name        = "name"
        static let latitude    = "location.lat"
        static let longitude   = "location.lng"
        static let distance    = "location.distance"
    }
    
}
