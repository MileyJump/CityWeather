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
    
    var outputForecastData: Observable<[ForecastList]?> = Observable(nil)
    var outputDailyForecastData: Observable<[DailyForecast]?> = Observable(nil)
    
    var outputCurrentData: Observable<CurrentWeatherModel?> = Observable(nil)
    
    
    init() {
        print("WeatherViewModel, init============================")
        // 초기화 시 API 요청
        weatherRequest()
    }
    
    deinit {
        print("WeatherViewModel, Deinit============================")
    }
    
    // inputWeatherData가 변경되면 API 요청
    private func weatherRequest() {
        inputWeatherData.bind { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            let id = data.0
            let lat = data.1
            let lon = data.2
            
            // API 요청 후 필터링된 데이터를 저장하도록 수정
            self.callRequest(api: WeatherRequest.forecast(lat: lat, lon: lon), weatherType: WeatherForecastModel.self) { [weak self] forecast in
                guard let self = self else { return }
                if let forecast = forecast {
                    self.outputForecastData.value = forecast.list
                    // 필터링된 일별 날씨 데이터를 추출하여 outputForecastData에 저장
                    let dailtForecasts = self.createDailyForecasts(from: forecast.list)
                    self.outputDailyForecastData.value = dailtForecasts
                }
            }
            // 현재 날씨 데이터를 요청하고 outputCurrentData에 저장
            self.callRequest(api: WeatherRequest.current(id: id), weatherType: CurrentWeatherModel.self) { [weak self] current in
                guard let self = self else { return }
                if let current = current {
                    self.outputCurrentData.value = current
                }
            }
        }
        
    }
    
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
    private func createDailyForecasts(from forecastList: [ForecastList]) -> [DailyForecast] {
        var dailyForecasts = [String: [ForecastList]]() // 문자열을 키, 배열을 값으로 딕셔너리
        
        // 날짜별로 예보 데이터를 그룹화
        for forecast in forecastList { // 받은 ForecastList를 반복문
            let date = forecast.dt_txt.split(separator: " ")[0] // 공백을 기준으로 분리 : "2024-07-12 15:00:00" -> "2024-07-12"
            let dateString = String(date) // 날짜를 문자열로 반환!
            if dailyForecasts[dateString] == nil { // 해당 날짜에 해당하는 키가 없으면 빈 배열 초기화!!
                dailyForecasts[dateString] = []
            }
            dailyForecasts[dateString]?.append(forecast) // 키 있으면 값 추가
        }
        
        // 각 날짜별로 평균 기온을 계산하여 dailyForecasts 배열에 추가
        var dailyForecastsResult = [DailyForecast]() // dailyForecastsResult을 초기화 (DailyForecast는 계산한 값이 들어갈 공간
        let sortedDates = dailyForecasts.keys.sorted() // 딕셔너리는 날짜가 순서대로 안 돼서 추가 함. 키(날짜 String)을 정렬
        for date in sortedDates {
            if let forecasts = dailyForecasts[date] { // 해당 날짜에 해당하는 값을 forecasts 할당
                //  forecast(값) 객체의 main.temp.. 값을 가져와 배열로 만들고, 배열의 모든 값을 더한 후 나누어 평균 값 구하기
                let averageTempMin = forecasts.map { $0.main.temp_min }.reduce(0, +) / Double(forecasts.count)
                let averageTempMax = forecasts.map { $0.main.temp_max }.reduce(0, +) / Double(forecasts.count)
                let weatherIcon = forecasts.first?.weather.first?.icon ?? "star" // 아이콘은 그냥 첫 번째거 가져오기!! 없으면? 그냥 star 로
                // 아까 생성한 빈 배열에 새 객체(데이터) 추가
                dailyForecastsResult.append(DailyForecast(date: date, temp_min: averageTempMin, temp_max: averageTempMax, icon: weatherIcon))
            }
        }
        return dailyForecastsResult
    }
}
