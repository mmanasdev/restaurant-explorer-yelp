//
//  SearchService.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 8/11/23.
//

import Foundation

protocol SearchServiceProtocol {
    func search(location: String, completion: @escaping (Result<Businesses, Error>) -> Void)
}

class SearchService: SearchServiceProtocol {
    
    let networkService: NetworkManagerProtocol!
    init(networkService: NetworkManagerProtocol) {
        self.networkService = networkService
    }
    
    internal func search(location: String, completion: @escaping (Result<Businesses, Error>) -> Void)  {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "location", value: location),
            URLQueryItem(name: "limit", value: "20")
        ]
        
        let httpRequest = HTTPRequest(method: .get, path: "search", queryItems: queryItems)
        
        networkService.performRequest(request: httpRequest, completion: completion)
    }
}
