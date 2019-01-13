//
//  BasePhotoResponse.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 09/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation
import ObjectMapper

public class BasePhotoResponse: Mappable {
    var photos: [PhotoResponse]?
    var code: Int?
    var photosCount: Int?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        photos      <- map[APIFields.photos]
        code        <- map[APIFields.code]
        photosCount <- map[APIFields.photosCount]
    }
    
    private struct APIFields {
        static let photos      = "response.photos.items"
        static let code        = "meta.code"
        static let photosCount = "response.photos.count"
    }
}

