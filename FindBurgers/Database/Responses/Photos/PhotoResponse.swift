//
//  PhotoResponse.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 09/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation
import ObjectMapper

public class PhotoResponse: Mappable {
    var id: String?
    var prefix: String?
    var suffix: String?
    var width: Int?
    var height: Int?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id     <- map[APIFields.id]
        prefix <- map[APIFields.prefix]
        suffix <- map[APIFields.suffix]
        width  <- map[APIFields.width]
        height <- map[APIFields.height]
    }
    
    private struct APIFields {
        static let id     = "id"
        static let prefix = "prefix"
        static let suffix = "suffix"
        static let width  = "width"
        static let height = "height"
    }
    
}
