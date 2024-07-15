//
//  WeatherViewModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//
import Foundation
import Alamofire

final class WeatherViewModel {
    
    var inputWeatherData: Observable<(Int, Double, Double)?> = Observable(nil)
    
    var outputForecaseData: Observable<[ForecaseList]?> = Observable(nil)
    var outputDailyForecaseData: Observable<[DailyForecast]?> = Observable(nil)
    
    var outputCurrentData: Observable<CurrentWeatherModel?> = Observable(nil)
    
    
    init() {
        // 초기화 시 API 요청
        weatherRequest()
    }
    
    // inputWeatherData가 변경되면 API 요청
    private func weatherRequest() {
        inputWeatherData.bind { data in
            guard let data = data else { return }
            let id = data.0
            let lat = data.1
            let lon = data.2
            
            // API 요청 후 필터링된 데이터를 저장하도록 수정
            self.callRequest(api: WeatherRequest.forecase(lat: lat, lon: lon), weatherType: WeatherForecaseModel.self) { forecase in
                if let forecase = forecase {
                    self.outputForecaseData.value = forecase.list
                    // 필터링된 일별 날씨 데이터를 추출하여 outputForecaseData에 저장
                    let dailtForecasts = self.createDailyForecasts(from: forecase.list)
                    self.outputDailyForecaseData.value = dailtForecasts
                }
            }
            // 현재 날씨 데이터를 요청하고 outputCurrentData에 저장
            self.callRequest(api: WeatherRequest.current(id: id), weatherType: CurrentWeatherModel.self) { current in
                if let current = current {
                    self.outputCurrentData.value = current
                }
            }
        }
        
    }
    //    37.51845 lat
    //    126.88494 lon
    //    1835847 id

    private func callRequest<T: Decodable>(api: WeatherRequest, weatherType: T.Type, completion: @escaping (T?) -> Void) {
        WeatherManager.shared.callRequest(api: api, modelType: weatherType) { (results: Result<T?, ErrorCode>) in
            switch results {
            case .success(let value):
                completion(value)  // 성공 시 completion 핸들러 호출
            case .failure(let failure):
                print(failure)
                completion(nil)  // 실패 시 nil로 completion 핸들러 호출
            }
        }
    }
    
    // 일별 날씨 예보 생성 메서드
    private func createDailyForecasts(from forecastList: [ForecaseList]) -> [DailyForecast] {
        var dailyForecasts = [String: [ForecaseList]]()
        
        // 날짜별로 예보 데이터를 그룹화
        for forecast in forecastList {
            let date = forecast.dt_txt.split(separator: " ")[0]
            let dateString = String(date)
            if dailyForecasts[dateString] == nil {
                dailyForecasts[dateString] = []
            }
            dailyForecasts[dateString]?.append(forecast)
        }
        
        // 각 날짜별로 평균 기온과 날씨 설명을 계산하여 dailyForecasts 배열에 추가
        var dailyForecastsResult = [DailyForecast]()
        for (date, forecasts) in dailyForecasts {
            let averageTemp = forecasts.map { $0.main.temp }.reduce(0, +) / Double(forecasts.count)
            let averageTempMin = forecasts.map { $0.main.temp_min }.reduce(0, +) / Double(forecasts.count)
            let averageTempMax = forecasts.map { $0.main.temp_max }.reduce(0, +) / Double(forecasts.count)
            let weatherIcon = forecasts.first?.weather.first?.icon ?? "star"
            let weatherDescription = forecasts.first?.weather.first?.description ?? ""
            dailyForecastsResult.append(DailyForecast(date: date, temp: averageTemp, temp_min: averageTempMin, temp_max: averageTempMax, icon: weatherIcon, description: weatherDescription))
        }
        
        return dailyForecastsResult
    }
    
}
