//
//  ConditionViewModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/15/24.
//

import Foundation

final class ConditionViewModel {
    
    var outputWeatherData: Observable<[ForecastList]?> = Observable(nil)
    
    init() {
        print("ConditionViewModel========init")
    }
    
    deinit {
        print("ConditionViewModel========Deinit")
    }
}
