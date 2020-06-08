//
//  URL+.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-04.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

// Custom Methods to add GET url params ( Added for scaling )
extension URL {
   
    func addParams(params: [String: Any]?) -> URL {
        guard let params = params else {
            return self
        }
        var urlComp = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComp.queryItems = queryItems
        return urlComp.url!
    }
}
