//
//  DailyforecastTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//

import UIKit

class DailyforecastTableViewCell: BaseTableViewCell {
    
    let dayLabel = UILabel()
    
    let iconImageView = UIImageView()
    
    let minimum = UILabel()
    let maximum = UILabel()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .red
    }
    
    override func configureHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(minimum)
        contentView.addSubview(maximum)
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
    
    override func configureView() {
        dayLabel.text = "오늘"
        dayLabel.textColor = .white
        iconImageView.image = UIImage(systemName: "star")
        
        minimum.text = "최저 -2도"
        minimum.textColor = .white
        
        maximum.text = "최저 -2도"
        maximum.textColor = .white
    }
    
}
