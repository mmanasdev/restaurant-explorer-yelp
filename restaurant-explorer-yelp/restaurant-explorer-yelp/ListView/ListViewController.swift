//
//  ListViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 25/10/23.
//

import UIKit

class ListViewController: UIViewController {
    
    
    @IBOutlet weak private(set) var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")

//        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate {
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        return cell
        
    }
    
    
}
