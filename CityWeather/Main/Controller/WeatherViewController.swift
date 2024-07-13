//
//  ViewController.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import UIKit
import SnapKit

protocol WeatherIdDelegate: AnyObject {
    func idUpdateDelegate(id: Int)
}

final class WeatherViewController: BaseViewController, WeatherIdDelegate {
    
    
   
    
    // MARK: - Properties

    private let currentLocationLabel = {
        let label = UILabel()
        label.text = "Jeju City"
        label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let currentTemperatureLabel = {
        let label = UILabel()
        label.text = "5.9°"
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let weatherLabel = {
        let label = UILabel()
        label.text = "Broken Clouds \n 최고: 7.0°  |  최저: -4.2°"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let customTitleView = WeatherCustomTitleView()
    
    private let weatherTableView = UITableView()
    
    private let viewModel = WeatherViewModel()
    
    var id = 1835847 {
        didSet {
            print("=====")
            bindData(with: id)
            weatherTableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        bindData(with: id)
        setupNavigationBar()
    }
    
    @objc private func mapButtonTapped() {
        
    }
    
    @objc private func listButtonTapped() {
        let vc = CitySearchViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func bindData(with id: Int) {
        viewModel.inputWeatherData.value = id
        
        viewModel.outputCurrentData.bind { value in
            guard let value = value else { return }
            self.currentLocationLabel.text = value.name
            self.currentTemperatureLabel.text = value.temperatureCelsius.temp
            self.weatherLabel.text = "\(value.weather[0].description) \n 최고: \(value.temperatureCelsius.temp_max)  |  최저: \(value.temperatureCelsius.temp_min)"
        }
        
        viewModel.outputForecaseData.bind { value in
            self.weatherTableView.reloadData()
            
            guard let cell = self.weatherTableView.cellForRow(at: [0,0]) as? WeatherTableViewCell else { return }
            cell.collectionView.reloadData()
        }
    }
    
    func idUpdateDelegate(id: Int) {
        print(#function)
        self.id = id
    }
    
    
    // MARK: - UI 구성

    private func setupNavigationBar() {
        navigationController?.isToolbarHidden = false
        
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        mapButton.tintColor = .white
        listButton.tintColor = .white
        
        let barItems = [mapButton, flexibleSpace, listButton]
        self.toolbarItems = barItems
        
        navigationItem.backButtonTitle = ""
        
    }
    
    override func configureHierarchy() {
        view.addSubview(currentLocationLabel)
        view.addSubview(currentTemperatureLabel)
        view.addSubview(weatherLabel)
        view.addSubview(weatherTableView)
    }
    
    override func configureLayout() {
        
        currentLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(currentLocationLabel.snp.bottom).inset(10)
            make.centerX.equalTo(currentLocationLabel).offset(10)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).inset(10)
            make.centerX.equalTo(currentLocationLabel)
        }
        
        weatherTableView.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(80)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        weatherTableView.backgroundColor = .brown
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        weatherTableView.register(DailyIntervalTableViewCell.self, forCellReuseIdentifier: DailyIntervalTableViewCell.identifier)
        weatherTableView.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        
        
        //        weatherTableView.rowHeight = UITableView.automaticDimension
        weatherTableView.rowHeight = 200
        weatherTableView.estimatedRowHeight = 200
    }
}



// MARK: - TableView Delegate, DataSource

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType.allCases[indexPath.row]
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { fatalError("WeatherTableViewCell 다운캐스팅 실패") }
            cell.collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            cell.headerView.configureHeader(type: sectionType)
            return cell
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyIntervalTableViewCell.identifier, for: indexPath) as? DailyIntervalTableViewCell else { fatalError("DailyIntervalTableViewCell 다운캐스팅 실패") }
            if let value = viewModel.outputForecaseData.value {
                cell.weatherList = value
            }
            
            cell.headerView.configureHeader(type: sectionType)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell else { fatalError("DailyIntervalTableViewCell 다운캐스팅 실패") }
            cell.headerView.configureHeader(type: sectionType)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell else { fatalError("WeatherTableViewCell 다운캐스팅 실패") }
            //            cell.
            return cell
        }
        
    }
}

// MARK: - CollectionView Delegate, DataSource

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputForecaseData.value?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { fatalError("WeatherCollectionViewCell 다운캐스팅 실패") }
        guard let value = viewModel.outputForecaseData.value else { return cell }
        cell.configureCell(data: value[indexPath.row])
        return cell
    }
}