//
//  InjectionUseCase.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 08/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation

class InjectionUseCase {
    
    static func provideGetBurger() -> GetBurger {
        return GetBurger(apiDataSource: InjectionApiDataSource.provideFoursquareApiDataSource())
    }

}

