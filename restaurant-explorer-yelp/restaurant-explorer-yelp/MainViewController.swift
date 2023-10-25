//
//  ViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 25/10/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak private(set) var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak private(set) var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViewController()
    }
    
    private lazy var listViewController: ListViewController = {
            return ListViewController(nibName: "ListViewController", bundle: nil)
        }()
        
        private lazy var locationViewController: LocationViewController = {
            return LocationViewController(nibName: "LocationViewController", bundle: nil)
        }()
    
    private func setupInitialViewController() {
        addChild(listViewController)
        listViewController.view.frame = containerView.bounds
        containerView.addSubview(listViewController.view)
        listViewController.didMove(toParent: self)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            remove(child: locationViewController)
            add(child: listViewController)
        } else {
            remove(child: listViewController)
            add(child: locationViewController)
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

