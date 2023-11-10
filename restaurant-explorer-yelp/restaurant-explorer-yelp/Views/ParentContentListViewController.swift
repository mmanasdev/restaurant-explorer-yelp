//
//  ParentContentListViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 2/11/23.
//

import UIKit

protocol ParentContentListViewControllerDeleagate: AnyObject {
    func didSelectBusiness(_ business: Business, parentContentListViewController: ParentContentListViewController)
}

class ParentContentListViewController: UIViewController {
    
    weak var parentContentListDelegate:ParentContentListViewControllerDeleagate?
    
    private lazy var listViewController: ListViewController = {
            return ListViewController(nibName: "ListViewController", bundle: nil)
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        listViewController.listDelegate = self
        setupInitialViewController()
    }
    
    private func setupInitialViewController() {
        guard
            let listContainerView = setListContainerView()
        else { return }
        addChild(listViewController)
        listViewController.view.frame = listContainerView.bounds
        listContainerView.addSubview(listViewController.view)
        listViewController.didMove(toParent: self)
    }
    
    func setListContainerView() -> UIView? {
        return nil
    }
    
    func updateList(businesses: Businesses?) {
        listViewController.updateTable(businesses)
    }
}

extension ParentContentListViewController: ListViewControllerDelegate {
    func didSelectBusiness(_ business: Business, listViewController: ListViewController) {
        parentContentListDelegate?.didSelectBusiness(business, parentContentListViewController: self)
    }
}
