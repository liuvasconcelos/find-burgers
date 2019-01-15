//
//  BurgerPhotoResponse.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 14/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation
import ObjectMapper

public class BurgerPhotoResponse: Mappable {
    var urlWithBurger: String?
    
    convenience required public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        urlWithBurger <- map[APIFields.urlWithBurger]
    }
    
    private struct APIFields {
        static let urlWithBurger = "urlWithBurger"
    }
    
}
