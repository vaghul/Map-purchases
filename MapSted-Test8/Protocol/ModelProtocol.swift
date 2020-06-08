//
//  ModelProtocol.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-04.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

protocol ModelDelegate: class {
    
    func recievedResponce(refparam: ApiMethod)
    func errorResponce(_ value: String, refparam: ApiMethod)
    func completedGroupOperation(refparam: ApiMethod)
}

