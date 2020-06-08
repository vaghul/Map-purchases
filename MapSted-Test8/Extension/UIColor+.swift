//
//  UIColor+.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-04.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//


import UIKit

extension UIColor {
    
    class var lightBlue: UIColor {
        return UIColor(hex: "#A4EBF5")!
    }
    
    class var lightGreyBG: UIColor {
        return UIColor(hex: "#F3F3F3")!
    }
    
    class var darkGreyBG: UIColor {
        return UIColor(hex: "#CFD8DC")!
    }
    
    class var lightGreyText: UIColor {
        return UIColor(hex: "#7B8D93")!
    }
    
    class var darkGreyText: UIColor {
        return UIColor(hex: "#43484A")!
    }
    
    
    public convenience init?(hex: String) {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(
                red: CGFloat(0.0),
                green:  CGFloat(0.0),
                blue:  CGFloat(0.0),
                alpha: CGFloat(1.0))
            return
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
        return
    }
}
