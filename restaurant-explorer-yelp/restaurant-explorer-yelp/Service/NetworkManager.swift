//
//  NetworkManager.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 8/11/23.
//

import Foundation

// Define un protocolo para las operaciones de red que tu aplicación necesita
protocol NetworkManagerProtocol {
    func performRequest<T: Decodable>(request: HTTPRequest, completion: @escaping (Result<T, Error>) -> Void)
}


class NetworkManager: NetworkManagerProtocol {
    private let session: URLSession
    private let baseURL: URL = URL(string: "https://api.yelp.com/v3/businesses/")!
    private let apiKey: String = "wa0IDrjoA24mYq2ZtTQzBQ7XZwmcl7NvcYsvDFUgycTS8MvmIUx48AgkuZst-lPZXBtmH6ehkiCCSbiFHT91ahVcLhasVFZxTuo2xRIGD9SWv0L52AQRQvyCjhI4ZXYx"

    init(session: URLSession = .shared) {
        self.session = session
    }

    func performRequest<T: Decodable>(request: HTTPRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = baseURL.appendingPathComponent(request.path)
        guard var  components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        components.queryItems = request.queryItems

        guard let finalURL = components.url else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        // Always set the Authorization header
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }

        dataTask.resume()
    }
}
