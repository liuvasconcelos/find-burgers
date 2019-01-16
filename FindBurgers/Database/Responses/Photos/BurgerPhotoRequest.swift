//
//  BurgerPhotoRequest.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 14/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Alamofire

public class BurgerPhotoRequest {
    private let urls: [String]
    
    init(urls: [String]) {
        self.urls = urls
    }
    
    func asParameters() -> Parameters {
        return [
            APIField.urls: urls
        ]
    }
    
}

private struct APIField {
    static let urls = "urls"
}

