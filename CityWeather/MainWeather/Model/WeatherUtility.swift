//
//  WeatherUtility.swift
//  CityWeather
//
//  Created by 최민경 on 7/15/24.
//

import Foundation

// 섭씨 온도 변환하는 유틸리티(재사용성) 함수 -> 중복 코드가 많아서 뺌
struct TemperatureConverter {
    static func kelvinToCelsiusString(kelvin: Double) -> String {
        return String(format: "%.1f", kelvin - 273.15) + "°"
    }
}

struct TemperatureCelsius {
    var temp, temp_min, temp_max: String
    
    init(temp: Double, temp_min: Double, temp_max: Double) {
        self.temp = TemperatureConverter.kelvinToCelsiusString(kelvin: temp)
        self.temp_min = TemperatureConverter.kelvinToCelsiusString(kelvin: temp_min)
        self.temp_max = TemperatureConverter.kelvinToCelsiusString(kelvin: temp_max)
    }
}
