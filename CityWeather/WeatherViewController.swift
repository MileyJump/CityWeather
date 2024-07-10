//
//  ViewController.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import UIKit
import SnapKit

class WeatherViewController: BaseViewController {
    
    let currentLocationLabel = {
       let label = UILabel()
        label.text = "Jeju City"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let currentTemperatureLabel = {
       let label = UILabel()
        label.text = "5.9°"
        label.font = .systemFont(ofSize: 90)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let weatherLabel = {
       let label = UILabel()
        label.text = "Broken Clouds"
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    let temperatureLabel = {
       let label = UILabel()
        label.text = "최고: 7.0°  |  최저: -4.2°"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let hoursBackgroundView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let dayBackgroundView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    let hoursLabel = {
        let label = UILabel()
        label.text = "3시간 간격의 일기예보"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let dayLabel = {
        let label = UILabel()
        label.text = "5일 간의 일기예보"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    
    let weatherTableView = UITableView()
    
    let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let inset: CGFloat = 4
        let width = UIScreen.main.bounds.width - (spacing * 2) - (inset * 4)
        let height = UIScreen.main.bounds.height
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: inset, left: 20, bottom: inset, right: inset)
        layout.scrollDirection = .horizontal
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    override func configureHierarchy() {
        view.addSubview(currentLocationLabel)
        view.addSubview(currentTemperatureLabel)
        view.addSubview(weatherLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(hoursBackgroundView)
        view.addSubview(hoursLabel)
        view.addSubview(weatherCollectionView)
        view.addSubview(dayBackgroundView)
        view.addSubview(dayLabel)
        view.addSubview(weatherTableView)
        
        weatherCollectionView.backgroundColor = .brown
        weatherTableView.backgroundColor = .brown
    }
    
    override func configureLayout() {
        currentLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(currentLocationLabel.snp.bottom)
            make.centerX.equalTo(currentLocationLabel).offset(10)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom)
            make.centerX.equalTo(currentLocationLabel)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(5)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        hoursBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        hoursLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(hoursBackgroundView).inset(10)
        }
        
        weatherCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hoursLabel.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(hoursBackgroundView).inset(5)
        }
        
        dayBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(hoursBackgroundView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(view.snp.height).multipliedBy(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(dayBackgroundView).inset(10)
        }
        
        weatherTableView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(dayBackgroundView).inset(5)
        }
        
        
        
    }
    

}

