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
        print("CitySearchViewModel====init")
        inputCityListData.bind { [weak self] _ in
            guard let self = self else { return }
            self.parseCitiesJSON()
        }
    }
    
    deinit {
        print("CitySearchViewModel====Deinit")
    }
    
    
    private func parseCitiesJSON() {
        // Bundle.main을 사용하여 JSON 파일의 경로를 가져오기
        guard let jsonFilePath = Bundle.main.path(forResource: "CityList", ofType: "json") else {
            fatalError("CityList.json 파일을 찾을 수 없습니다.")
        }
        
        // 파일 경로에서 데이터를 읽어옵니당 ~
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            
            // JSON 데이터를 구조체 배열로 디코딩
            let cities = try JSONDecoder().decode([CityListModel].self, from: jsonData)
            
            // 디코딩 성공 시, CityListModel 배열에 넣기, 필터 배열도(검색용)!!
            outputCityListData.value = cities
            outputFilteredCityListData.value = cities
   
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    
    func filterCities(searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            outputFilteredCityListData.value = outputCityListData.value ?? [] // 값 없으면 다시 처음 들어있는 배열로!~
            return
        }
        
        guard let cities = outputCityListData.value else { return } // 옵셔널 해제 합시당
        
        let filteredCities = cities.filter { city in
            // 필터!! 이름이랑 국가를 소문자로(lowercased) 변환하여 포함 여부 찾기 -> 대소문자 구분 없애기
            return city.name.lowercased().contains(searchText.lowercased()) || city.country.lowercased().contains(searchText.lowercased())
        }
        // 필터 다 됐어? 담아버려
        outputFilteredCityListData.value = filteredCities
    }
}

