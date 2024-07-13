//
//  CitySearchViewModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import Foundation

final class CitySearchViewModel {
    
    var inputCityListData: Observable<Void?> = Observable(nil)
    
    var outputCityListData: Observable<[CityListModel]?> = Observable(nil)
    var outputFilteredCityListData: Observable<[CityListModel]> = Observable([])
    
    init() {
        inputCityListData.bind { _ in
            self.parseCitiesJSON()
        }
    }
    
    
    
    // 모델로 뺄까 말까..
    private func parseCitiesJSON() {
        // Bundle.main을 사용하여 JSON 파일의 경로를 가져옵니다.
        guard let jsonFilePath = Bundle.main.path(forResource: "CityList", ofType: "json") else {
            fatalError("CityList.json 파일을 찾을 수 없습니다.")
        }
        
        // 파일 경로에서 데이터를 읽어옵니다.
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            
            // JSON 데이터를 구조체 배열로 디코딩
            let cities = try JSONDecoder().decode([CityListModel].self, from: jsonData)
            
            outputCityListData.value = cities
            outputFilteredCityListData.value = cities
            
            // 디코딩 성공 시, cities 배열에 데이터가 들어있음
//            for city in cities {
//                print("\(city.name): (\(city.country)")
//            }
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    
    func filterCities(searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            outputFilteredCityListData.value = outputCityListData.value ?? [] // 값 없으면 다시 처음 들어있는 배열로!~
            return
        }
        
        guard let cities = outputCityListData.value else { return }
        
        let filteredCities = cities.filter { city in
            return city.name.lowercased().contains(searchText.lowercased()) || city.country.lowercased().contains(searchText.lowercased())
        }
        
        outputFilteredCityListData.value = filteredCities
  
    }
    
}
