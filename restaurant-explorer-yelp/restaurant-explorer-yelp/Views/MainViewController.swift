//
//  ViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 25/10/23.
//

import UIKit

class MainViewController: UIViewController {
    
    //  MARK: @IBOutlets
    @IBOutlet weak private(set) var segmentedControl: UISegmentedControl!
    @IBOutlet weak private(set) var containerView: UIView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchViewController: SearchViewController = {
        return SearchViewController(nibName: "SearchViewController", bundle: nil)
    }()
    
    private lazy var locationViewController: LocationViewController = {
        return LocationViewController(nibName: "LocationViewController", bundle: nil)
    }()
    
    //  MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yelp! Explorer"
        setupSegmentedControl()
        setupInitialViewController()
        setupSearchView()
    }
    
    //  MARK: Setup Views
    private func setupInitialViewController() {
        addChild(searchViewController)
        searchViewController.view.frame = containerView.bounds
        containerView.addSubview(searchViewController.view)
        searchViewController.didMove(toParent: self)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.setTitle("Search by Attr.", forSegmentAt: 0)
        segmentedControl.setTitle("Search by loc.", forSegmentAt: 1)
    }
    
    private func setupSearchView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by attributes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //  MARK: SegmentedControl Actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            remove(child: locationViewController)
            add(child: searchViewController)
            navigationItem.searchController = searchController
        } else {
            remove(child: searchViewController)
            add(child: locationViewController)
            navigationItem.searchController = nil
        }
    }
    
    private func add(child: UIViewController) {
        addChild(child)
        child.view.frame = containerView.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    private func remove(child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

// MARK: UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let textToSearch = searchBar.text else { return }
        print("searchBar.text: \(textToSearch)")
    }
    
    
}
