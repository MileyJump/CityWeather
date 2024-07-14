//
//  WeatherCollectionViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class WeatherCollectionViewCell: BaseCollectionViewCell {
    
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureCell(data: ForecaseList) {
        timeLabel.text = timeConversion(data.dt_txt)
        weatherImageView.kf.setImage(with: data.weather[0].iconExtraction)
        tempLabel.text = "\(data.temperatureCelsius.temp)"
        
    }
    
    private func timeConversion(_ dateString: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormat.date(from: dateString) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            return String(hour) + "시"
        }else {
            return "날짜 변환 실패"
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(tempLabel)
    }
    
    override func configureView() {
        timeLabel.backgroundColor = .red
        timeLabel.textAlignment = .center
        timeLabel.font = .systemFont(ofSize: 13)
        
        weatherImageView.backgroundColor = .systemMint
        
//        tempLabel.backgroundColor = .systemPink
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tempLabel.textColor = .white
        contentView.backgroundColor = .clear
        
    }
    
    override func configureLayout() {
//        timeLabel.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalToSuperview().inset(5)
////            make.height.equalTo(20)
//            make.bottom.equalToSuperview()
//            
//        }
//        
//
//        weatherImageView.snp.makeConstraints { make in
////            make.top.equalTo(timeLabel.snp.bottom).offset(10)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
////            make.height.equalTo(weatherImageView.snp.width)
//            make.horizontalEdges.equalToSuperview()
//        }
//        
        tempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
//            make.height.equalTo(10)
            
            //            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
            //            make.horizontalEdges.equalTo(timeLabel)
        }
    }
 
  
}
