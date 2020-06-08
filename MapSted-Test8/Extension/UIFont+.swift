//
//  UIFont+.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

extension UIFont {
    
    class var mediumTitle: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    class var semiboldTitle: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    class var boldAppTitle: UIFont {
        return UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    
    class var boldAppSubTitle: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
