//
//  SearchViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 26/10/23.
//

import UIKit

class SearchViewController: ParentContentListViewController {
    
    @IBOutlet weak var listContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setListContainerView() -> UIView? {
        return listContainerView
    }
}

