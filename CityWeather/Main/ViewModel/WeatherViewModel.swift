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
                     // 필터링된 일별 날씨 데이터를 추출하여 outputForecaseData에 저장
                     let filteredForecaseList = self.filterDailyWeather(from: forecase.list)
                     self.outputForecaseData.value = filteredForecaseList
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
//    private func callRequest<T: Decodable>(api: WeatherRequest, weatherType: T.Type) {
//        WeatherManager.shared.callRequest(api: api, modelType: weatherType) { (results: Result<T?, ErrorCode>) in
//            switch results {
//            case .success(let value):
//                if let forecase = value as? WeatherForecaseModel {
//                    self.outputForecaseData.value = forecase.list
//                    //                    print(forecase)
//                }
//                else if let current = value as? CurrentWeatherModel {
//                    self.outputCurrentData.value = current
//                }
//                
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
//    
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
    
// 날씨 리스트를 일별로 필터링하는 메서드
func filterDailyWeather(from weatherList: [ForecaseList]) -> [ForecaseList] {
    // 날짜별로 날씨 데이터를 그룹화하기 위한 딕셔너리
    var groupedWeather = [String: [ForecaseList]]()

    for weather in weatherList {
        let dateString = String(weather.dt_txt.prefix(10))  // 날짜 문자열 추출
        if groupedWeather[dateString] == nil {
            groupedWeather[dateString] = [weather]
        } else {
            groupedWeather[dateString]?.append(weather)
        }
    }

    // 각 그룹에서 첫 번째 항목을 추출하여 일별 날씨 리스트 생성
    let dailyWeather = groupedWeather.compactMap { $0.value.first }
    return dailyWeather
}
}
