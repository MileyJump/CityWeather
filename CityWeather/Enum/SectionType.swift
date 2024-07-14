//
//  SectionType.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//

import UIKit

enum SectionType: CaseIterable {
    case header
    case timeInterval
    case dailyInterval
    case location
    
    var sectionTitle: String {
        switch self {
        case .header:
            return ""
        case .timeInterval:
            return "3시간 간격의 일기예보"
        case .dailyInterval:
            return "5일 간의 일기예보"
        case .location:
            return "위치"
        }
    }
    
    var sectionImage: String {
        switch self {
        case .header:
            return ""
        case .timeInterval:
            return "calendar"
        case .dailyInterval:
            return "calendar"
        case .location:
            return "thermometer.low"
        }
    }
}
