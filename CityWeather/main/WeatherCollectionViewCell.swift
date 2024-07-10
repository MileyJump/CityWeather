//
//  WeatherCollectionViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import UIKit
import SnapKit

final class WeatherCollectionViewCell: BaseCollectionViewCell {
    
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(tempLabel)
        
        timeLabel.backgroundColor = .red
        timeLabel.text = "12시"
        timeLabel.textAlignment = .center
        timeLabel.font = .systemFont(ofSize: 13)
        
        weatherImageView.backgroundColor = .blue
        weatherImageView.backgroundColor = .systemMint
        
        contentView.backgroundColor = .blue
    }
    
    override func configureLayout() {
        timeLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.horizontalEdges.equalToSuperview()
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom)
            
        }
//        
//        weatherImageView.snp.makeConstraints { make in
//            make.top.equalTo(timeLabel.snp.bottom).offset(10)
//            make.horizontalEdges.equalTo(timeLabel)
//        }
        
//        tempLabel.snp.makeConstraints { make in
//            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
//            make.horizontalEdges.equalTo(timeLabel)
//        }
    }
    
}
