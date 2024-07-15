//
//  CurrentWeatherModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let coord: CurrentCoord
    let weather: [CurrentWeather]
    let base: String
    let main: CurrentMain
    let visibility: Int
    let wind: CurrentWind
    let clouds : clouds
    let dt: Int
    let sys: CurrentSys
    let timezone: Int
    let id: Int
    let name: String?
    let cod: Int
    
    var temperatureCelsius: TemperatureCelsius {
        return TemperatureCelsius(main: main)
    }
}

struct CurrentCoord: Decodable {
    let lon: Double
    let lat: Double
}

struct CurrentWeather: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CurrentMain: Decodable {
    let temp, feels_like, temp_min, temp_max : Double
    let pressure, humidity, grnd_level: Int
}

struct CurrentWind: Decodable {
    let speed: Double
    let deg: Int
}

struct clouds: Decodable {
    let all: Int
}

struct CurrentSys: Decodable {
    let type, id, sunrise, sunset: Int
    let country: String
}
    

// 섭씨 온도로 변환
struct TemperatureCelsius {
    var temp, temp_min, temp_max: String
    
    init(main: CurrentMain) {
        self.temp = String(format: "%.1f", main.temp - 273.15) + "°"
        self.temp_min = String(format: "%.1f", main.temp - 273.15) + "°"
        self.temp_max = String(format: "%.1f", main.temp - 273.15) + "°"
    }
}
