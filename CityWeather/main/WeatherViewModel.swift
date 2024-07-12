//
//  WeatherViewModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//
import Foundation
import Alamofire

final class MarketViewModel {
    
    var inputWeatherData: Observable<Void?> = Observable(nil)

    var outputWeatherData: Observable<[Weather]?> = Observable(nil)
    
    
    init() {
        weatherRequest()
    }
    
    private func weatherRequest() {
        inputWeatherData.bind { _ in
            self.callRequest()
        }
    }
    
    private func callRequest() {
        WeatherManager.shared.callRequest(api: .forecase) { (weather: [Weather]?, error: String?) in
            if let weather = weather {
                self.outputWeatherData.value = weather
            } else if let error = error {
                print(error)
            }
        }
    }
}
    
    
    
    

