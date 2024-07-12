//
//  CustomHeaderView.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//

import UIKit
import SnapKit

class CustomHeaderView: UITableViewHeaderFooterView {
    
    let iconImageViwe = UIImageView()
    let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(iconImageViwe)
        contentView.addSubview(titleLabel)
    }
    
    func configureLayout() {
        iconImageViwe.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
            make.size.equalTo(24)
            make.leading.equalTo(10)
            make.top.equalToSuperview().offset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageViwe.snp.trailing).offset(10)
            make.top.equalToSuperview()
        }
    }
    
    func configureHeader(title: String, imageName: String) {
        titleLabel.text = title
        iconImageViwe.image = UIImage(systemName: imageName)
    }
}
