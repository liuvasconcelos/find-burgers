//
//  ShowBurgersCollectionViewCell.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 13/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit

class ShowBurgersCollectionViewCell: UICollectionViewCell {
    public static let NIB_NAME   = "ShowBurgersCollectionViewCell"
    public static let IDENTIFIER = "ShowBurgersCollectionViewCellIdentifier"
    
    @IBOutlet weak var imageView: UIImageView!
    
    var burger:  VenueDto?
    var cellContract: ShowBurgersCollectionViewCellDelegate?
    
    func configureView(burger: VenueDto) {
        self.burger = burger
        imageView.layer.cornerRadius = 5
        if let photo = burger.photo {
            imageView.set(image: photo)
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        cellContract?.showBurgerDetails(title: self.burger?.name ?? "", photo: self.burger?.photo ?? "")
    }
    
}

