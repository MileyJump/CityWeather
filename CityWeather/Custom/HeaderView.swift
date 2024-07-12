//
//  HeaderView.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//


import UIKit
import SnapKit

class HeaderView: BaseView {
    
    let iconImageViwe = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    func configureHeader(type: SectionType) {
        titleLabel.text = type.sectionTitle
        iconImageViwe.image = UIImage(systemName: type.sectionImage)
    }

    override func configureHierarchy() {
        addSubview(iconImageViwe)
        addSubview(titleLabel)
    }
    
    override func configureLayout() {
        iconImageViwe.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(18)
            make.leading.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageViwe)
            make.leading.equalTo(iconImageViwe.snp.trailing).offset(5)
        }
    }
  
    override func configureView() {
        titleLabel.textColor = .white
        iconImageViwe.tintColor = .white
        titleLabel.font = .systemFont(ofSize: 14)
    }
}
