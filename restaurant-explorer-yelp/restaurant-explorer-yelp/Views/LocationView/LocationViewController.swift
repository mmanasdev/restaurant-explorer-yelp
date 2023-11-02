//
//  LocationViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 25/10/23.
//

import UIKit

class LocationViewController: ParentContentListViewController {

    @IBOutlet weak var listContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setListContainerView() -> UIView? {
        return listContainerView
    }

}
