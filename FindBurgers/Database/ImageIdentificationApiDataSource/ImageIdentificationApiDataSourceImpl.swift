//
//  ImageIdentificationApiDataSourceImpl.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ImageIdentificationApiDataSourceImpl: ImageIdentificationApiDataSource {
    
    private static var INSTANCE: ImageIdentificationApiDataSourceImpl?
    
    public static func getInstance() -> ImageIdentificationApiDataSourceImpl {
        if (INSTANCE == nil) {
            INSTANCE = ImageIdentificationApiDataSourceImpl()
        }
        
        return INSTANCE!
    }
    
    public static func destroyInstance() {
        INSTANCE = nil
    }
    
    func lookForBurguersBy(venuesPhotosUrl: [String], _ loadCallback: @escaping (BaseCallback<BurgerPhotoResponse>) -> Void) {
        let path    = "https://pplkdijj76.execute-api.eu-west-1.amazonaws.com/prod/recognize"
        
        let params = BurgerPhotoRequest(urls: venuesPhotosUrl).asParameters()
        
        Alamofire.request(path, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject {
            (response: DataResponse<BurgerPhotoResponse>) in
            switch(response.result) {
            case .success(let response):
                loadCallback(BaseCallback.success(response))
                break
            case .failure(let error):
                loadCallback(BaseCallback.failed())
                break
            }
        }
    
    }
    
    
}
