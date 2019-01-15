//
//  ImageIdentificationApiDataSource.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation

protocol ImageIdentificationApiDataSource {
    func lookForBurguersBy(venuesPhotosUrl: [String], _ loadCallback: @escaping (BaseCallback<BurgerPhotoResponse>) -> Void)
}
