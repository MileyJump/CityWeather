//
//  WeatherRequest.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import Foundation
import Alamofire

enum WeatherRequest {
    case forecast(lat: Double, lon: Double)
    case current(id: Int)
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var endPoint: URL {
        switch self {
        case .forecast(let lat, let lon):
            return URL(string: baseURL + "forecast?lat=\(lat)&lon=\(lon)&")!
        case .current(let id):
            return URL(string: baseURL + "weather?id=\(id)&")!
            //            1846266
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    
    var parameter: Parameters {
        switch self {
        case .forecast, .current:
            return ["appid" : APIKey.shared.weatherForecast]
        }
    }
}
