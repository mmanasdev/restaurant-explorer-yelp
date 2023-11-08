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
    private let searchService: SearchServiceProtocol
    
    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService

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
        
        
        self.searchService.search(word: searchTerm) {[weak self] result in
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
    
    
    
}
