//
//  WeatherRequest.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import Foundation
import Alamofire

enum WeatherRequest {
    case forecase(lat: Double, lon: Double)
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var endPoint: URL {
        switch self {
        case .forecase(let lat, let lon):
            return URL(string: baseURL + "forecast?lat=\(lat)&lon=\(lon)&")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    
    var parameter: Parameters {
        switch self {
        case .forecase:
            return ["appid" : APIKey.shared.weatherForecase]
        }
    }
}
