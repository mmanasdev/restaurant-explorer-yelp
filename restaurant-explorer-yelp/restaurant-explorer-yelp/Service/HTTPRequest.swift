//
//  HTTPRequest.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 8/11/23.
//

import Foundation

enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    // ... agregar más métodos según sea necesario
}

struct HTTPRequest {
    let method: HTTPRequestMethod
    let path: String
    let queryItems: [URLQueryItem]?
    let headers: [String: String]?
    let body: Data?
    
    init(method: HTTPRequestMethod,
         path: String,
         queryItems: [URLQueryItem]? = nil,
         headers: [String: String]? = nil,
         body: Data? = nil) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
