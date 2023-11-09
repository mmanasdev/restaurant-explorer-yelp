//
//  AppCoordinator.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 9/11/23.
//

import Foundation
import UIKit

protocol Coordinating {
    func start()
}

class AppCoordinator: Coordinating {
    private let window: UIWindow
        private let rootNavigationController: UINavigationController
        private let storyboard: UIStoryboard

    init(window: UIWindow, storyboard: UIStoryboard = UIStoryboard(name: "MainViewController", bundle: nil)) {
            self.window = window
            self.rootNavigationController = UINavigationController()
            self.storyboard = storyboard
        }

    func start() {
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
                    fatalError("MainViewController not found in Storyboard")
                }
        let networkManager = NetworkManager()
        let searchService = SearchService(networkService: networkManager)
        let searchViewModel = MainViewModel(searchService: searchService)
        mainViewController.searchViewModel = searchViewModel
        rootNavigationController.viewControllers = [mainViewController]

        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
}
