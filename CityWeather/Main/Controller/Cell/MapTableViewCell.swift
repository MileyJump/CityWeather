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
    private var coordinates: CLLocationCoordinate2D?
    
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
        backgroundColor = .clear
        
//        mapView.delegate = self
        
        // 기본 위치 설정 (예: 서울 좌표)
        let initialLocation = CLLocation(latitude: 37.51845, longitude: 126.88494)
        centerMapOnLocation(location: initialLocation)
        
        // 경도와 위도를 기반으로 마커 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.51845, longitude: 126.88494)
        annotation.title = "새싹"
        mapView.addAnnotation(annotation)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
           let regionRadius: CLLocationDistance = 1000
           let coordinateRegion = MKCoordinateRegion(
               center: location.coordinate,
               latitudinalMeters: regionRadius * 2.0,
               longitudinalMeters: regionRadius * 2.0)
           mapView.setRegion(coordinateRegion, animated: true)
       }
    
}

