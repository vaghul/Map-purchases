//
//  URLSession+.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-04.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

import Foundation

// Network Call request Wrapper using swift Result's

extension URLSession {
    
    func dataTask(with url: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

