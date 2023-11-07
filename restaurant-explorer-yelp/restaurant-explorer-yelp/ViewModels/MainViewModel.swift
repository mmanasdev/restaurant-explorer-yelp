//
//  MainViewModel.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 7/11/23.
//


import Foundation
import Combine

class MainViewModel {
    // Propiedades publicadas que la vista puede observar
    @Published var searchText: String = ""
    @Published var searchResults: Businesses?
//    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
//    private let searchService: SearchServiceProtocol
    init() {
//    init(searchService: SearchServiceProtocol) {
//        self.searchService = searchService

        // Establece el enlace para realizar una búsqueda cada vez que el texto cambie
        $searchText
            .removeDuplicates() // Evita la búsqueda si el texto no ha cambiado
            .debounce(for: 0.2, scheduler: RunLoop.main) // Añade un retraso para evitar búsquedas por cada letra
            .sink { [weak self] in self?.performSearch(searchTerm: $0) }
            .store(in: &cancellables)
    }

    private func performSearch(searchTerm: String) {
        guard !searchTerm.isEmpty else {
            searchResults = nil
            return
        }
        
        
        search(word: searchTerm) {[weak self] result in
            DispatchQueue.main.async {
//                self?.isLoading = false
                switch result {
                case .success(let results):
                    self?.searchResults = results
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    private func search(word: String, completion: @escaping (Result<Businesses, Error>) -> Void)  {

        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer wa0IDrjoA24mYq2ZtTQzBQ7XZwmcl7NvcYsvDFUgycTS8MvmIUx48AgkuZst-lPZXBtmH6ehkiCCSbiFHT91ahVcLhasVFZxTuo2xRIGD9SWv0L52AQRQvyCjhI4ZXYx"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.yelp.com/v3/businesses/search?location=\(word)&limit=20")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
            } else {
                let httpResponse = response as? HTTPURLResponse
                guard let data = data else { return }
                do{
                    let businesses = try JSONDecoder().decode(Businesses.self, from: data)
                    print(businesses)
                    completion(.success(businesses))
                }catch{
                    
                }
                
            }
        })
        
        dataTask.resume()
    }
    
}
