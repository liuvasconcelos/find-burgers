//
//  UIImageViewExtension.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 13/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func set(image: String) {
        if let url = NSURL(string: image) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}

