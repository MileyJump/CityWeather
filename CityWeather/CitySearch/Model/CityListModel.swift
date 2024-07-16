//
//  CityListModel.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import Foundation

struct CityListModel: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: CityCoord
}

struct CityCoord: Codable {
    let lon: Double
    let lat: Double
}
