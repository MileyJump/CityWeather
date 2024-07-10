//
//  WeatherRequest.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import Foundation
import Alamofire

enum WeatherRequest {
    case forecase
    
    var baseURL: String {
        return " https://api.openweathermap.org/data/2.5/"
    }
    
    var endPoint: URL {
        switch self {
        case .forecase:
            return URL(string: baseURL + "forecast?lat=44.34&lon=10.99&")!
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
