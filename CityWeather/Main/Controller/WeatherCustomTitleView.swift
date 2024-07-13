//
//  WeatherCustomTitleView.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit

class WeatherCustomTitleView: BaseView {

//    let titleLabel = UILabel()
//    let temperatureLabel = UILabel()
//    let descriptionLabel = UILabel()
//    
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

   

    override func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [currentLocationLabel, currentTemperatureLabel, weatherLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func updateWithScrollOffset(_ offset: CGFloat) {
        // 스크롤 오프셋에 따라 타이틀을 업데이트하는 로직
        if offset > 50 {
            currentLocationLabel.text = "스크롤 시 타이틀"
            currentTemperatureLabel.text = "온도"
            weatherLabel.text = "설명"
        } else {
            currentLocationLabel.text = nil
            currentTemperatureLabel.text = nil
            weatherLabel.text = nil
        }
    }
}
