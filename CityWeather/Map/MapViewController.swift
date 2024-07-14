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
    
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    override func configureLayout() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}
