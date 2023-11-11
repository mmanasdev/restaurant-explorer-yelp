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
        bindViewModel()
    }
    
    private func bindViewModel() {
        searchViewModel.$searchResults
                .receive(on: RunLoop.main)
                .sink { [weak self] businesses in
                    self?.searchViewController.updateList(businesses: businesses)
                }
                .store(in: &cancellables)
        }
    
    //  MARK: Setup Views
    private func setupInitialViewController() {
        addChild(searchViewController)
        searchViewController.view.frame = containerView.bounds
        containerView.addSubview(searchViewController.view)
        searchViewController.didMove(toParent: self)
        searchViewController.parentContentListDelegate = self
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
        self.searchViewModel.searchText = textToSearch
    }
}

extension MainViewController: ParentContentListViewControllerDeleagate {
    func didSelectBusiness(_ business: Business, parentContentListViewController: ParentContentListViewController) {
        let detailViewController = DetailViewController(business: business)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
