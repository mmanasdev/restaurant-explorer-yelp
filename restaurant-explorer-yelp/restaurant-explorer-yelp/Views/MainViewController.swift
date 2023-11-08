//
//  ViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 25/10/23.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    //  MARK: @IBOutlets
//    @IBOutlet weak private(set) var segmentedControl: UISegmentedControl!
    @IBOutlet weak private(set) var containerView: UIView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchViewModel: MainViewModel!
    private lazy var searchViewController: SearchViewController = {
        return SearchViewController(nibName: "SearchViewController", bundle: nil)
    }()
    private var cancellables = Set<AnyCancellable>()
    
    //  MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yelp! Explorer"
        setupInitialViewController()
        setupSearchView()
        
        let searchService = SearchService(networkService: NetworkManager())
        searchViewModel = MainViewModel(searchService: searchService)
        bindViewModel()
    }
    
    private func bindViewModel() {
        searchViewModel.$searchResults
                .receive(on: RunLoop.main)
                .compactMap { $0 }
                .sink { [weak self] bbb in
                    print("weak")
                    self?.searchViewController.updateList(businesses: bbb)
                }
                .store(in: &cancellables)

            // Añadir más enlaces según sea necesario
        }
    
    //  MARK: Setup Views
    private func setupInitialViewController() {
        addChild(searchViewController)
        searchViewController.view.frame = containerView.bounds
        containerView.addSubview(searchViewController.view)
        searchViewController.didMove(toParent: self)
    }
    
    private func setupSearchView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by location"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    
}

// MARK: UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let textToSearch = searchBar.text else { return }
        print("searchBar.text: \(textToSearch)")
        self.searchViewModel.searchText = textToSearch
//        search(word: textToSearch) { result in
//            switch result {
//            case .success(let bus):
//                self.searchViewController.updateList(businesses: bus)
//                break
//            case .failure(let err): break
//            }
//        }
    }
    
    
}
