////
////  File.swift
////  CityWeather
////
////  Created by 최민경 on 7/12/24.
////
//
//import Foundation
////
////  ViewController.swift
////  CityWeather
////
////  Created by 최민경 on 7/10/24.
////
//
//import UIKit
//import SnapKit
//
//final class WeatherViewController: BaseViewController {
//    
//    private let currentLocationLabel = {
//       let label = UILabel()
//        label.text = "Jeju City"
//        label.font = .systemFont(ofSize: 40)
//        label.textColor = .white
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let currentTemperatureLabel = {
//       let label = UILabel()
//        label.text = "5.9°"
//        label.font = .systemFont(ofSize: 90)
//        label.textColor = .white
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let weatherLabel = {
//       let label = UILabel()
//        label.text = "Broken Clouds \n 최고: 7.0°  |  최저: -4.2°"
//        label.font = .systemFont(ofSize: 22)
//        label.textColor = .white
//        label.textAlignment = .center
//        return label
//    }()
//    
////    private let temperatureLabel = {
////       let label = UILabel()
////        label.text = "최고: 7.0°  |  최저: -4.2°"
////        label.font = .boldSystemFont(ofSize: 20)
////        label.textColor = .white
////        label.textAlignment = .center
////        return label
////    }()
//    
////    private let hoursBackgroundView = {
////        let view = UIView()
////        view.backgroundColor = .white.withAlphaComponent(0.3)
////        view.layer.cornerRadius = 10
////        return view
////    }()
////
////    private let dayBackgroundView = {
////        let view = UIView()
////        view.backgroundColor = .white.withAlphaComponent(0.3)
////        view.layer.borderColor = UIColor.black.cgColor
////        view.layer.cornerRadius = 10
////        return view
////    }()
////
////    private let hoursLabel = {
////        let label = UILabel()
////        label.text = "3시간 간격의 일기예보"
////        label.textColor = .white
////        label.font = .systemFont(ofSize: 13)
////        return label
////    }()
////
////    private let dayLabel = {
////        let label = UILabel()
////        label.text = "5일 간의 일기예보"
////        label.textColor = .white
////        label.font = .systemFont(ofSize: 13)
////        return label
////    }()
//    
//    private let weatherTableView = UITableView()
//    
////    private let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
////
////    static private func layout() -> UICollectionViewLayout {
////        let layout = UICollectionViewFlowLayout()
////        let spacing: CGFloat = 10
////        let inset: CGFloat = 15
////        let numberOfItemsPerRow: CGFloat = 5 // 한 줄에 보여질 아이템 개수
////        let totalSpacing = (2 * inset) + ((numberOfItemsPerRow - 1) * spacing)
////
////        let width = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
////        let height = UIScreen.main.bounds.height
////
////        layout.itemSize = CGSize(width: width, height: height)
////        layout.minimumLineSpacing = spacing
////        layout.minimumInteritemSpacing = inset
////        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        layout.scrollDirection = .horizontal
////
////        return layout
////    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .blue
////        scrollView.backgroundColor = .brown
////        contentView.backgroundColor = .red
//        
//        
//    }
//    
//
//    override func configureHierarchy() {
////        view.addSubview(scrollView)
////        view.addSubview(contentView)
//        view.addSubview(currentLocationLabel)
//        view.addSubview(currentTemperatureLabel)
//        view.addSubview(weatherLabel)
////        contentView.addSubview(temperatureLabel)
////        contentView.addSubview(hoursBackgroundView)
////        contentView.addSubview(hoursLabel)
////        contentView.addSubview(weatherCollectionView)
////        contentView.addSubview(dayBackgroundView)
////        contentView.addSubview(dayLabel)
//        view.addSubview(weatherTableView)
//    }
//    
//    override func configureLayout() {
////        scrollView.snp.makeConstraints { make in
////            make.edges.equalTo(view.safeAreaLayoutGuide)
////        }
////
////        contentView.snp.makeConstraints { make in
////            make.width.height.equalTo(view)
////            make.top.bottom.equalTo(scrollView)
////
////        }
////
//        currentLocationLabel.snp.makeConstraints { make in
//            make.top.equalTo(view).offset(10)
//            make.centerX.equalTo(view)
//        }
//        
//        currentTemperatureLabel.snp.makeConstraints { make in
//            make.top.equalTo(currentLocationLabel.snp.bottom)
//            make.centerX.equalTo(currentLocationLabel).offset(10)
//        }
//        
//        weatherLabel.snp.makeConstraints { make in
//            make.top.equalTo(currentTemperatureLabel.snp.bottom)
//            make.centerX.equalTo(currentLocationLabel)
//        }
//        
////        temperatureLabel.snp.makeConstraints { make in
////            make.top.equalTo(weatherLabel.snp.bottom).offset(5)
////            make.centerX.equalTo(contentView)
////        }
////
////        hoursBackgroundView.snp.makeConstraints { make in
////            make.top.equalTo(temperatureLabel.snp.bottom).offset(50)
////            make.horizontalEdges.equalTo(contentView).inset(10)
////            make.height.equalTo(view.snp.height).multipliedBy(0.25)
////        }
////
////        hoursLabel.snp.makeConstraints { make in
////            make.top.leading.equalTo(hoursBackgroundView).inset(10)
////        }
////
////        weatherCollectionView.snp.makeConstraints { make in
////            make.top.equalTo(hoursLabel.snp.bottom).offset(10)
////            make.bottom.horizontalEdges.equalTo(hoursBackgroundView).inset(5)
////        }
////
////        dayBackgroundView.snp.makeConstraints { make in
////            make.top.equalTo(hoursBackgroundView.snp.bottom).offset(10)
////            make.horizontalEdges.equalTo(contentView).inset(10)
////            make.height.equalTo(hoursBackgroundView.snp.height).multipliedBy(1.5)
////
////        }
////
////        dayLabel.snp.makeConstraints { make in
////            make.top.leading.equalTo(dayBackgroundView).inset(10)
////        }
//        
//        weatherTableView.snp.makeConstraints { make in
//            make.top.equalTo(weatherLabel.snp.bottom).offset(10)
//            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
//        }
//        
//        
//        
//    }
//    
//    override func configureView() {
////        weatherCollectionView.delegate = self
////        weatherCollectionView.dataSource = self
////        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
//        
//        weatherTableView.delegate = self
//        weatherTableView.dataSource = self
//        weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
//        
//        weatherTableView.rowHeight = 50
//    }
//
//}
//
//extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { fatalError("WeatherCollectionViewCell 다운캐스팅 실패") }
//        
//        return cell
//    }
//}
//
//extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { fatalError("WeatherTableViewCell 다운캐스팅 실패") }
//        
//        return cell
//    }
//    
//    
//}
