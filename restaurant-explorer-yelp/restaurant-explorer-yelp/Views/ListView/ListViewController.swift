//
//  ListViewController.swift
//  restaurant-explorer-yelp
//
//  Created by Miguel Mañas Alvarez on 25/10/23.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak private(set) var tableView: UITableView!
    
    var businessesMock: Businesses!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
//        fetchMockModels()
    }
}

extension ListViewController {
    func updateTable(_ businesses: Businesses?) {
        self.businessesMock = businesses
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListViewController {
    fileprivate func configureTableView() {
        tableView.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
    
    fileprivate func fetchMockModels() {
        let bundle = Bundle(for: type(of: self))
        
        guard
            let url = bundle.url(forResource: "BusinessMock", withExtension: "json")
        else { return }
        
        do {
            let json = try Data(contentsOf: url)
            let businessesMock: Businesses = try JSONDecoder().decode(Businesses.self, from: json)
            self.businessesMock = businessesMock
        } catch {}
    }
}

extension ListViewController: UITableViewDelegate { }

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessesMock?.businesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell,
            let businesses = businessesMock.businesses
        else { return UITableViewCell() }
        
        cell.configureCellWith(businesses[indexPath.row])
        
        return cell
    }
}
