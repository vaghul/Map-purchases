//
//  Analytics.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-05.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

// Network call Decoder JSON

struct Analytics:Codable {
    var manufacturer:String?
    var market_name:String?
    var codename:String?
    var model:String?
    var usage_statistics:Statistics?
}

struct Statistics : Codable {
    var session_infos:[SessionData]?
}

struct SessionData: Codable{
    var building_id:Int?
    var purchases:[Purchase]?
}

struct Purchase:Codable {
  
    var item_id:Int?
    var item_category_id:Int?
    var cost:Double?
    
}
