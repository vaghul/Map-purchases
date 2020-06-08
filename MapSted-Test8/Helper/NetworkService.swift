//
//  NetworkService.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-04.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}
struct EmptyRequest: Codable {}

// Custom Network Service Handler Result Type

class NetworkService {
    
    public static let shared = NetworkService()
    
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
    
    func buildRequest<E: Encodable>(url: URL, method: HTTPMethod, headers: [String: String]?, body: E?) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        if let requestHeaders = headers {
            for (key, value) in requestHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let requestBody = body {
            if !(requestBody is EmptyRequest) {
                let encoder = JSONEncoder();
                request.httpBody = try? encoder.encode(requestBody)
            }
        }
        return request
    }
    
    func fetchResources<T: Decodable, E:Encodable>(url: URL?, method:HTTPMethod, params : [String:Any]?,body:E?, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlConstruct = url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlConstruct = urlConstruct.addParams(params: params)
    
        let request = self.buildRequest(url: urlConstruct, method: method, headers: [:], body: body)
                
        urlSession.dataTask(with: request) { (result) in
            switch result {
            case .success(let (response, data)):

                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    print((response as? HTTPURLResponse)?.statusCode ?? "NA")
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch (let error) {
                    print(error)
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.apiError))
            }
        }.resume()
    }
    
}
