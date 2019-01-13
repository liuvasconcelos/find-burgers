//
//   ShowAllBurgersContract.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation

protocol ShowAllBurgersPresenterContract {
    func findBurgersNear(latitude: Double, longitude: Double)
}

protocol  ShowAllBurgersViewContract {
    func showNear(venue: VenueDto)
    func showBurgerDetails(title: String, photo: String)
}

protocol ShowBurgersCollectionViewCellDelegate: class {
    func showBurgerDetails(title: String, photo: String)
}
