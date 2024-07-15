//
//  MapViewController.swift
//  CityWeather
//
//  Created by 최민경 on 7/14/24.
//

import UIKit
import MapKit
import SnapKit

final class MapViewController: BaseViewController {
    
    let viewModel = MapViewModel()
    
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    override func configureLayout() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func bindData() {
        viewModel.outputLocationData.bind { value in
            guard let value = value else { return }
            self.configureMapLocation(data: value)
        }
    }
    
    private func configureMapLocation(data: CurrentWeatherModel) {
        // 기본 위치 설정 (예: 서울 좌표)
        let initialLocation = CLLocation(latitude: data.coord.lat, longitude: data.coord.lon)
        centerMapOnLocation(location: initialLocation)
        
        // 경도와 위도를 기반으로 마커 추가
        let annotation = MKPointAnnotation() // 마커 생성
        annotation.coordinate = CLLocationCoordinate2D(latitude: data.coord.lat, longitude: data.coord.lon) // 마커 좌표
        annotation.title = "나의 위치"
        mapView.addAnnotation(annotation)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
           let regionRadius: CLLocationDistance = 1000 // 반경 1000미터 설정
           let coordinateRegion = MKCoordinateRegion(
               center: location.coordinate,
               latitudinalMeters: regionRadius * 2.0,
               longitudinalMeters: regionRadius * 2.0)
           mapView.setRegion(coordinateRegion, animated: true)
       }
}
