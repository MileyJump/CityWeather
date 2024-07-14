//
//  MapTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit
import MapKit
import SnapKit

final class MapTableViewCell: BaseTableViewCell {
    
    private let bgView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let headerView = HeaderView()

    private let mapView = MKMapView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    override func configureHierarchy() {
        contentView.addSubview(bgView)
        bgView.addSubview(headerView)
        bgView.addSubview(mapView)
    }
    
    override func configureLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(5)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(bgView).offset(5)
            make.height.equalTo(20)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(mapView.snp.width)
        }
    }
    
    override func configureView() {
        mapView.backgroundColor = .systemPink
    }
    
}
