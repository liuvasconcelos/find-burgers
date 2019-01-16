//
//  UIViewExtension.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 13/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit

extension UIView {

    func addGradient(_ color1: CGColor = UIColor.blue.cgColor, _ color2: CGColor = UIColor.purple.cgColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.frame.size
        gradient.colors = [color1, color2]
        
        self.layer.insertSublayer(gradient, at: 0)
        
    }
}

