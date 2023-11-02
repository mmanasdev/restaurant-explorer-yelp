//
//  LocationViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 25/10/23.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var listContainerView: UIView!
    
    
    private lazy var listViewController: ListViewController = {
        return ListViewController(nibName: "ListViewController", bundle: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialViewController()
    }
    
    private func setupInitialViewController() {
        addChild(listViewController)
        listViewController.view.frame = listContainerView.bounds
        listContainerView.addSubview(listViewController.view)
        listViewController.didMove(toParent: self)
    }

}
