//
//  MapViewModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/15/24.
//

import Foundation

final class MapViewModel {
    
    var inputLocationData: Observable<CurrentWeatherModel?> = Observable(nil)
    
    var outputLocationData: Observable<CurrentWeatherModel?> = Observable(nil)
    
    init() { 
        bindData()
    }
    
    
    private func bindData() {
        inputLocationData.bind { [weak self] value in
            guard let self = self else { return }
            self.outputLocationData.value = value
        }
    }
    
}
