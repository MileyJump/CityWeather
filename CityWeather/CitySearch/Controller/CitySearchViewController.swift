//
//  CitySearchViewController.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit
import SnapKit

class CitySearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let viewModel = CitySearchViewModel()
    var delegate: WeatherIdDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
    }
    
    // MARK: - Method
    
    private func bindData() {
        viewModel.outputFilteredCityListData.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Setup AddTarget
    
    @objc private func ellipsisButtonTapped() {
        print(#function)
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "City"
        
        let ellipsisButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(ellipsisButtonTapped))
        navigationItem.rightBarButtonItem = ellipsisButton
    }
   
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableHeaderView = searchBar
    }
    
    override func configureView() {
        view.backgroundColor = .black
        
        searchBar.placeholder = "Search for a city"
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        tableView.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CitySearchTableViewCell.self, forCellReuseIdentifier: CitySearchTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.separatorStyle = .none
    }
}

// MARK: - TableView Delegate, DataSource

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputFilteredCityListData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySearchTableViewCell.identifier, for: indexPath) as? CitySearchTableViewCell else { fatalError("WeatherTableViewCell 다운캐스팅 실패") }
         let cityList = viewModel.outputFilteredCityListData.value
            cell.configureCell(cityList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityData = viewModel.outputFilteredCityListData.value[indexPath.row]
        delegate?.idUpdateDelegate(id: cityData.id, lat: cityData.coord.lat, lon: cityData.coord.lon)
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - SearchBar Delegate

extension CitySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCities(searchText: searchText)
    }
}
