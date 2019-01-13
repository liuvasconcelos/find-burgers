//
//  BurgerDetailsViewController.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 06/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit

class BurgerDetailsViewController: UIViewController, BurgerDetailsViewContract {
    
    public static let NIB_NAME = "BurgerDetailsViewController"

    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func set(title: String, photo: String) {
        venueTitle.text  = title
        
        if let url = NSURL(string: photo) {
            if let data = NSData(contentsOf: url as URL) {
                venueImage.image = UIImage(data: data as Data)
            }
        }
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
