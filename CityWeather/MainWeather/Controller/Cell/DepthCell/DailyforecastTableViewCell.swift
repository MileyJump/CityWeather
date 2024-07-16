//
//  DailyforecastTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//

import UIKit
import Kingfisher
import SnapKit

final class DailyforecastTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let dayLabel = UILabel()
    
    private let iconImageView = UIImageView()
    
    private let minimum = UILabel()
    private let maximum = UILabel()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Method
    
    private func dayConversion(_ dateString: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        dateFormat.locale = Locale(identifier: "ko_KR")
        
        if let date = dateFormat.date(from: dateString) {
            dateFormat.dateFormat = "E"
            let dayOfWeek = dateFormat.string(from: date)
            
            return dayOfWeek
        }else {
            return "날짜 변환 실패"
        }
    }
    
    // MARK: - UI
    
    override func configureHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(minimum)
        contentView.addSubview(maximum)
    }
    
    func configureCell(data: DailyForecast) {
        print(data.date)
        dayLabel.text = dayConversion(data.date)
        iconImageView.kf.setImage(with: data.iconExtraction)
        minimum.text = "최저 \(data.tempMinCelsius)"
        maximum.text = "최고 \(data.tempMaxCelsius)"
    }
    
    override func configureView() {
        backgroundColor = .clear
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView).inset(5)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.equalTo(dayLabel.snp.trailing).offset(50)
            make.centerY.equalTo(contentView)
        }
        
        minimum.snp.makeConstraints { make in
            make.verticalEdges.equalTo(dayLabel)
            make.leading.equalTo(iconImageView.snp.trailing).offset(5)
        }
        
        maximum.snp.makeConstraints { make in
            make.verticalEdges.equalTo(dayLabel)
            make.trailing.equalTo(contentView).inset(5)
        }
    }
}
