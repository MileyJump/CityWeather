//
//  ConditionsCollectionViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit

final class ConditionsCollectionViewCell: BaseCollectionViewCell {
    
    private let bgView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let headerView = HeaderView()
    
    let informationLabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "1.35m/s"
        label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        return label
    }()
    
    let pressureLabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "hap"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let addInformationLabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "강풍: 4.42m/s"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(bgView)
        bgView.addSubview(headerView)
        bgView.addSubview(informationLabel)
        bgView.addSubview(pressureLabel)
        bgView.addSubview(addInformationLabel)
    }
    
    override func configureLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(bgView).inset(5)
            make.height.equalTo(20)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(bgView).inset(15)
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom)
            make.horizontalEdges.equalTo(informationLabel)
        }
        
        addInformationLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(informationLabel)
            make.bottom.equalTo(bgView.snp.bottom).offset(-10)
        }
    }
    
    func configureCell(_ data: CurrentWeatherModel ) {
        
    }
    
    override func configureView() {
        headerView.titleLabel.textColor = .systemGray2
        headerView.iconImageViwe.tintColor = .systemGray2
    }
}
