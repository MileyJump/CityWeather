//
//  CitySearchTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit

class CitySearchTableViewCell: BaseTableViewCell {
    
    let hashtagLabel = {
        let label = UILabel()
        label.text = "#"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    
    let nameLabel = {
        let label = UILabel()
        label.text = "Heunghae"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let countryLabel = {
        let label = UILabel()
        label.text = "KR"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(hashtagLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryLabel)
    }
    
    override func configureLayout() {
        hashtagLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(hashtagLabel.snp.top).offset(5)
            make.leading.equalTo(hashtagLabel.snp.trailing).offset(10)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel.snp.leading)
            make.bottom.equalTo(10)
        }
    }
    
}
