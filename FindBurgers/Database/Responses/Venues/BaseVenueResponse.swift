//
//  BaseVenueResponse.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 08/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation
import ObjectMapper

public class BaseVenueResponse: Mappable {
    var response: [VenueResponse]?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        response <- map[APIFields.response]
        
    }
    
    private struct APIFields {
        static let response = "response.venues"
    }
    
}

