//
//  Reusable.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import Foundation
import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension UIViewController: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
