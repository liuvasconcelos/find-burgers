//
//  ShowBurgersCollectionView.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 13/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit

class ShowBurgersCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ShowBurgersCollectionViewCellDelegate {

    var burgers = [VenueDto]()
    var viewContract: ShowAllBurgersViewContract?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate        = self
        self.dataSource      = self
        self.allowsSelection = false
        
        let cell = UINib(nibName: ShowBurgersCollectionViewCell.NIB_NAME, bundle: nil)
        self.register(cell, forCellWithReuseIdentifier: ShowBurgersCollectionViewCell.IDENTIFIER)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return burgers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowBurgersCollectionViewCell.IDENTIFIER, for: indexPath as IndexPath) as? ShowBurgersCollectionViewCell
        
        guard let burgerCell = cell else { return ShowBurgersCollectionViewCell() }
        burgerCell.configureView(burger: self.burgers[indexPath.row])
        burgerCell.cellContract = self
        return burgerCell
    }
    
    func set(burgers: [VenueDto]) {
        self.burgers = burgers
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(155), height: CGFloat(155))
    }

    func showBurgerDetails(title: String, photo: String) {
        self.viewContract?.showBurgerDetails(title: title, photo: photo)
    }
    
}

