//
//  DetailViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 11/11/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    let business: Business!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("business: \(business)")
    }
    
    init(business: Business) {
        self.business = business
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
