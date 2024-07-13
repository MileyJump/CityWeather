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
    let viewModel = CitySearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bindData()
    }
    
    func bindData() {
        viewModel.outputCityListData.bind { value in
            
        }
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
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableHeaderView = searchBar
    }
    
    override func configureView() {
        searchBar.placeholder = "Search for a city"
        searchBar.backgroundImage = UIImage()
        tableView.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CitySearchTableViewCell.self, forCellReuseIdentifier: CitySearchTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
//        tableView.separatorStyle = .none
    }
    
    
    
}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cityList = viewModel.outputCityListData.value else { return 0 }
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySearchTableViewCell.identifier, for: indexPath) as? CitySearchTableViewCell else { fatalError("WeatherTableViewCell 다운캐스팅 실패") }
        if let cityList = viewModel.outputCityListData.value {
            cell.configureCell(cityList[indexPath.row])
        }
        return cell
    }
}
