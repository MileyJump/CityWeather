//
//  WeatherViewModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//
import Foundation
import Alamofire

final class WeatherViewModel {
    
    var inputWeatherData: Observable<Void?> = Observable(nil)

    var outputWeatherData: Observable<HourIntervaModel?> = Observable(nil)
    
    
    init() {
        weatherRequest()
    }
    
    private func weatherRequest() {
        inputWeatherData.bind { _ in
            self.callRequest(api: WeatherRequest.forecase(lat: 37.51845, lon: 126.88494), weatherType: HourIntervaModel.self)
        }
    }
    
    private func callRequest<T: Decodable>(api: WeatherRequest, weatherType: T.Type) {
        WeatherManager.shared.callRequest(api: api, modelType: weatherType) { (results: Result<T?, ErrorCode>) in
            switch results {
            case .success(let value):
                if let hour = value as? HourIntervaModel {
                    self.outputWeatherData.value = hour
                    print(hour)
                }
//                    else if let daily = value as?
        
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
    
    
    
    

