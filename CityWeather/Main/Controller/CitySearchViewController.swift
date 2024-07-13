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
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    
}
