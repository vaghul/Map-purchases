//
//  Bulding.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-05.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

// Network call Decoder JSON

struct Building: Codable {
    
    var building_id:Int?
    var building_name:String?
    var city:String?
    var state:String?
    var country:String?
}
