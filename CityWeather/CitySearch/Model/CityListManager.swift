//
//  CityListManager.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//


import Foundation


//class CityListManager {
//    
//    static let shared = CityListManager()
//    
//    private init() { }
    
//    private func parseCitiesJSON() {
//        // Bundle.main을 사용하여 JSON 파일의 경로를 가져옵니다.
//        guard let jsonFilePath = Bundle.main.path(forResource: "CityList", ofType: "json") else {
//            fatalError("CityList.json 파일을 찾을 수 없습니다.")
//        }
//        
//        // 파일 경로에서 데이터를 읽어옵니다.
//        do {
//            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
//            
//            // JSON 데이터를 구조체 배열로 디코딩
//            let cities = try JSONDecoder().decode([CityListModel].self, from: jsonData)
//            
//            // 디코딩 성공 시, cities 배열에 데이터가 들어있음
//            for city in cities {
//                print("\(city.name): (\(city.country)")
//            }
//        } catch {
//            print("Error decoding JSON: \(error.localizedDescription)")
//        }
//    }
//}
