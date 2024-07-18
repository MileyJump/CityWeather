//
//  ViewController.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import UIKit
import SnapKit

protocol WeatherIdDelegate: AnyObject {
    func idUpdateDelegate(id: Int, lat: Double, lon: Double)
}

final class WeatherViewController: BaseViewController, WeatherIdDelegate {

    // MARK: - Properties
    
    private let bgImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "하늘")
        return image
    }()
    
    private let weatherTableView = UITableView()
    
    private let viewModel = WeatherViewModel()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        bindData(id: 1835847, lat: 37.51845, lon: 126.88494 )
        setupNavigationBar()
    }
    
    
    deinit {
        print("WeatherViewController=========deinit=====================")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Setup AddTarget
    
    @objc private func mapButtonTapped() {
        let vc = MapViewController()
        vc.viewModel.inputLocationData.value = viewModel.outputCurrentData.value
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func listButtonTapped() {
        let vc = CitySearchViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Method
    
    private func bindData(id: Int, lat: Double, lon: Double) {
        viewModel.inputWeatherData.value = (id, lat, lon)

        viewModel.outputCurrentData.bind { [weak self] _ in
            guard let self = self else { return }
            self.weatherTableView.reloadData()
        }
        
        viewModel.outputDailyForecastData.bind { [weak self] value in
            guard let self = self else { return }
            guard let cell = self.weatherTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? WeatherTableViewCell else { return }
            cell.collectionView.reloadData()
        }
    }
    
    // MARK: - Delegate Method
    
    func idUpdateDelegate(id: Int, lat: Double, lon: Double) {
        print(#function)
        viewModel.inputWeatherData.value = (id, lat, lon)
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
        view.addSubview(bgImageView)
        view.addSubview(weatherTableView)
    }
    
    override func configureLayout() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        weatherTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        weatherTableView.backgroundColor = .clear
        weatherTableView.separatorStyle = .none
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
   
        weatherTableView.register(CustomHeaderView.self, forCellReuseIdentifier: CustomHeaderView.identifier)
        weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        weatherTableView.register(DailyIntervalTableViewCell.self, forCellReuseIdentifier: DailyIntervalTableViewCell.identifier)
        weatherTableView.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        weatherTableView.register(ConditionsTableViewCell.self, forCellReuseIdentifier: ConditionsTableViewCell.identifier)
    }
}



// MARK: - TableView Delegate, DataSource

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType.allCases[indexPath.row]
        switch sectionType {
        case .header:
            guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: CustomHeaderView.identifier, for: indexPath) as? CustomHeaderView else {
                // 형변환 실패 시 기본 UITableViewCell 반환
                return UITableViewCell()
            }
            if let value = viewModel.outputCurrentData.value {
                // viewModel에서 데이터 가져와서 셀에 설정
                cell.configureCell(value)
            }
            return cell
            
        case .timeInterval :
            guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
            
            cell.collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.headerView.configureHeader(type: sectionType)
            return cell
        case .dailyInterval :
            guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: DailyIntervalTableViewCell.identifier, for: indexPath) as? DailyIntervalTableViewCell else { return UITableViewCell() }
            if let value = viewModel.outputDailyForecastData.value {
                cell.viewModel.inputForecastListData.value = value
            }
            
            cell.headerView.configureHeader(type: sectionType)
            return cell
        case .location:
            guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell else { return UITableViewCell() }
            cell.headerView.configureHeader(type: sectionType)
            if let value = viewModel.outputCurrentData.value {
                cell.configureMapLocation(data: value)
            }
            return cell
        case .conditions:
            guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: ConditionsTableViewCell.identifier, for: indexPath) as? ConditionsTableViewCell else { return UITableViewCell() }
            cell.viewModel.outputWeatherData.value = viewModel.outputForecastData.value
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 3 {
                let vc = MapViewController()
                vc.viewModel.inputLocationData.value = viewModel.outputCurrentData.value
                navigationController?.pushViewController(vc, animated: true)
                tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            }
        }
        
        // 테이블뷰 화면에 표시 되기 직전에 호출
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == 3 {
                cell.selectionStyle = .default
                cell.isUserInteractionEnabled = true
            } else {
                cell.selectionStyle = .none // 선택 스타일을 none으로 설정하여 선택 효과를 막음
                cell.isUserInteractionEnabled = false // 셀의 사용자 상호작용을 비활성화
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let cellCase = SectionType.allCases[indexPath.row]
            switch cellCase {
            case .header:
                return 270
            case .timeInterval:
                return 200
            case .dailyInterval:
                return 240
            case .location:
                return 300
            case .conditions:
                return 480
            }
        }
    }
}

// MARK: - CollectionView Delegate, DataSource

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.outputForecastData.value?.count ?? 5
        return viewModel.outputDailyForecastData.value?.count ?? 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { fatalError("WeatherCollectionViewCell 다운캐스팅 실패") }
        guard let value = viewModel.outputForecastData.value else { return cell }
        cell.configureCell(data: value[indexPath.row])
        return cell
    }
}
