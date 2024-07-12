//
//  WeatherManager.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import Foundation
import Alamofire

enum ErrorCode: Error {
    case invalidResponse
    case noData
    case decodingFailed
    case networkError(String)
}

final class WeatherManager {
    
    static let shared = WeatherManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(api: WeatherRequest, modelType: T.Type, completionHandler: @escaping (Result<T?, ErrorCode>) -> Void) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: modelType) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(let error):
                    completionHandler(.failure(.invalidResponse))
                    print("\(modelType)==Error=============")
                    print(error)
                }
            }
    }
}

