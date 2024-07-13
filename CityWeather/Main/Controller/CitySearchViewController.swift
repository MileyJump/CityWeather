//
//  CitySearchViewController.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit
import SnapKit

class CitySearchViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "City"
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = searchBar
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.register(CitySearchTableViewCell.self, forCellReuseIdentifier: CitySearchTableViewCell.identifier)
    }
    
    
    
}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySearchTableViewCell.identifier, for: indexPath) as? CitySearchTableViewCell else { fatalError("WeatherTableViewCell 다운캐스팅 실패") }
        return cell
    }
}
