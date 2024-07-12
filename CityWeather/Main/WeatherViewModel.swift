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

    var outputForecaseData: Observable<[List]?> = Observable(nil)
    var outputCurrentData: Observable<CurrentWeatherModel?> = Observable(nil)
    
    
    init() {
        weatherRequest()
    }
    
    private func weatherRequest() {
        inputWeatherData.bind { _ in
            self.callRequest(api: WeatherRequest.forecase(lat: 37.51845, lon: 126.88494), weatherType: ForecaseModel.self)
            self.callRequest(api: WeatherRequest.current(id: 1835847), weatherType: CurrentWeatherModel.self)
        }
    }
    
    private func callRequest<T: Decodable>(api: WeatherRequest, weatherType: T.Type) {
        WeatherManager.shared.callRequest(api: api, modelType: weatherType) { (results: Result<T?, ErrorCode>) in
            switch results {
            case .success(let value):
                if let forecase = value as? ForecaseModel {
                    self.outputForecaseData.value = forecase.list
//                    print(forecase)
                }
                else if let current = value as? CurrentWeatherModel {
                    self.outputCurrentData.value = current
                }
        
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
    
    
    
    

