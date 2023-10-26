//
//  SearchViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 26/10/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var listContainerView: UIView!
    
    private lazy var listViewController: ListViewController = {
            return ListViewController(nibName: "ListViewController", bundle: nil)
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "BusinessMock", withExtension: "json") else {
            return
        }
        
        guard let json = try? Data(contentsOf: url) else { return  }
        
        let businessesMock: Businesses = try! JSONDecoder().decode(Businesses.self, from: json)
        setupInitialViewController()
    }
    
    private func setupInitialViewController() {
        addChild(listViewController)
        listViewController.view.frame = listContainerView.bounds
        listContainerView.addSubview(listViewController.view)
        listViewController.didMove(toParent: self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
