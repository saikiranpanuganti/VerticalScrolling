//
//  NetworkAdaptor.swift
//  OTT-App-B3
//
//  Created by Saikiran Panuganti on 13/07/22.
//

import Foundation
import UIKit

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkAdaptor {
    static func urlRequest(urlString: String, method: HttpMethod = .get, headers: [String: String]? = nil, urlParameters: [String: String]? = nil, bodyParameters: [String: Any]? = nil, completion: @escaping ((Data?, URLResponse?, Error?) -> ())) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil, nil)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        do {
            if let bodyParameters = bodyParameters {
                let body = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
                urlRequest.httpBody = body
            }
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                completion(data, response, error)
            }.resume()
        }catch {
            completion(nil, nil, error)
        }
    }
}
