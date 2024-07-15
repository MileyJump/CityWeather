//
//  DailyIntervalViewModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/15/24.
//

import Foundation

final class DailyIntervalViewModel {
    
    var inputForecastListData: Observable<[DailyForecast]> = Observable([])

    var outputForecastListData: Observable<[DailyForecast]> = Observable([])
    
    init() {
        bind()
    }
    
    private func bind() {
        // input 이 자식! 신호 받았니? 그러면 output에 값 좀 줘라 ~
        inputForecastListData.bind { value in
            self.outputForecastListData.value = value
        }
    }
    
}


