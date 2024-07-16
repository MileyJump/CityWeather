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
    case conditions
    
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
        case .conditions:
            return ""
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
        case .conditions:
            return ""
        }
    }
}


// 마지막 셀, 컬렉션뷰셀 헤더 타이틀
enum collectionHeaderType:String, CaseIterable {
    case wind
    case cloud
    case pressure
    case humidity
    
    
    var sectionTitle: String {
        switch self {
        case .wind:
            return "바람 속도"
        case .cloud:
            return "구름"
        case .pressure:
            return "기압"
        case .humidity:
            return "속도"
        }
    }
    
    var sectionImage: String {
        switch self {
        case .wind:
            return "wind"
        case .cloud:
            return "drop.fill"
        case .pressure:
            return "thermometer.low"
        case .humidity:
            return "humidity"
        }
    }
}
