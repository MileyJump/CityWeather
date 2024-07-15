//
//  HeaderTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/14/24.
//

import UIKit

final class CustomHeaderView: BaseTableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: CurrentWeatherModel) {
        currentLocationLabel.text = data.name
        currentTemperatureLabel.text = "\(data.temperatureCelsius.temp)"
        
        weatherLabel.text =  "\(data.weather[0].description) \n 최고: \(data.temperatureCelsius.temp_max)  |  최저: \(data.temperatureCelsius.temp_min)"
    }
    
    override func configureHierarchy() {
        addSubview(currentLocationLabel)
        addSubview(currentTemperatureLabel)
        addSubview(weatherLabel)
    }
    
    override func configureLayout() {
        currentLocationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(currentLocationLabel.snp.bottom).inset(10)
            make.centerX.equalTo(currentLocationLabel).offset(10)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).inset(10)
            make.centerX.equalTo(currentLocationLabel)
        }
    }
}
