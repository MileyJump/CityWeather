//
//  WeatherManager.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import Foundation
import Alamofire

final class WeatherManager {
    
    static let shared = WeatherManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(api: WeatherRequest, completionHandler: @escaping ([T]?, String?) -> Void) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding.queryString).validate(statusCode: 200..<500).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
