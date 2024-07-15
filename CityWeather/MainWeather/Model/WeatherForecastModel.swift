//
//  WeatherModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import Foundation

struct WeatherForecastModel: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastList]
    let city: City
}

struct ForecastList: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys?
    let dt_txt: String
    
    var temperatureCelsius: TemperatureCelsiusForecast {
        return TemperatureCelsiusForecast(main: main)
    }
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
    
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    var iconExtraction: URL? {
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else {
            return nil
        }
        return url
        
    }
}

struct Clouds: Decodable {
    let all: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Rain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Sys: Decodable {
    let pod: String
}
                
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct Coord: Decodable {
    let lat, lon: Double
}


// 섭씨 온도로 변환
struct TemperatureCelsiusForecast {
    var temp, temp_min, temp_max: String
    
    init(main: Main) {
        self.temp = String(format: "%.1f", main.temp - 273.15) + "°"
        self.temp_min = String(format: "%.1f", main.temp - 273.15) + "°"
        self.temp_max = String(format: "%.1f", main.temp - 273.15) + "°"
    }
}


struct DailyForecast {
    let date: String
    let temp_min: Double
    let temp_max: Double
    let icon: String
    
    var iconExtraction: URL? {
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else {
            return nil
        }
        return url
    }
}
