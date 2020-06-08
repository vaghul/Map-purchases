//
//  TableViewDataSource.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation


struct TableViewDataSource {
    
    var title:String
    var selection:Any
    var value:String?
    var isCost = true
    var pickerSource:[Any]?
    var queryKey:String?
}

struct TableViewHeaderSource {
    var title:String
    var source:[TableViewDataSource]
}
