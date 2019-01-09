//
//  ShowAllBurgersPresenter.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

class ShowAllBurgersPresenter: ShowAllBurgersPresenterContract {
    private let view:      ShowAllBurgersViewContract
    private let getBurger: GetBurger
    
    init(view: ShowAllBurgersViewContract, getBurger: GetBurger) {
        self.view      = view
        self.getBurger = getBurger
    }
    
    func findBurgersNear(latitude: Double, longitude: Double) {
        getBurger.findBurgersNear(latitude: latitude, longitude: longitude) { (callback) in
            callback.onSuccess({ (burgers) in
                self.view.showNear(burgers: burgers)
            })
            callback.onFailed({ (error) in
                print("falha")
            })
        }
    }
}

