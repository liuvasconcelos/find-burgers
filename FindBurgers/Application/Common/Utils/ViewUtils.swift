//
//  ViewUtils.swift
//  FindBurgers
//
//  Created by Livia Vasconcelos on 07/01/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import Foundation

class ViewUtils {
    
    static func loadNibNamed<T>(_ nibName: String, owner: Any?) -> T {
        return Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?[0] as! T
    }
    
}
