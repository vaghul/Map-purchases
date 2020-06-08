//
//  ApiUrl.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-04.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

// enum implement to handle Endpoint and Create URL object of the same

public enum ApiUrl: String {
    
    case BuildingInfos = "http://positioning-test.mapsted.com/api/Values/GetBuildingData/"
    case AnalyticsData = "http://positioning-test.mapsted.com/api/Values/GetAnalyticData/"
    
    var url: URL? {
           return URL(string: self.rawValue)
       }
}
