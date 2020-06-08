//
//  StaticHelper.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class StaticHelper {
    
    static let shared = StaticHelper()
    
    static func getPaddingView() -> UIView {
        let view  = UIView()
        let arrow = UIImageView(image:  UIImage(named: "image-down-arrow")!)
        if let size = arrow.image?.size {
            view.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10, height: 50)
            arrow.frame = CGRect(x: 0.0, y: 25 - size.height/2, width: size.width, height: size.height)
        }
        view.addSubview(arrow)
        return view
    }
    
    static func getEmptypadding() -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
    }
}
