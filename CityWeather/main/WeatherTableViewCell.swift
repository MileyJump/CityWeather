//
//  WeatherTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import UIKit

class WeatherTableViewCell: BaseTableViewCell {
    
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let lowestTempLabel = UILabel()
    private let highestTempLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(lowestTempLabel)
        contentView.addSubview(highestTempLabel)
    }
    
    override func configureLayout() {
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(30)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.trailing).offset(40)
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(weatherImageView.snp.height)
        }
        
        lowestTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView.snp.trailing).offset(10)
            make.verticalEdges.equalToSuperview()
        }
        
        highestTempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.verticalEdges.equalToSuperview()
        }
        
    }
    
    override func configureView() {
        self.backgroundColor = .red
        
        timeLabel.text = "오늘"
        weatherImageView.backgroundColor = .brown
        lowestTempLabel.text = "최저 -2"
        highestTempLabel.text = "최고 9"
    }
    
    
    
}
