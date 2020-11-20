//
//  Common.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-20.
//

import Foundation

public struct CommonWeatherModelOpearaions {
    static func getSFIconsForWeatherCondition(_ conditionID: Int) -> String {
        switch conditionID {
        case 200 ... 232:
            return "cloud.bolt.rain"
        case 300 ... 321:
            return "cloud.drizzle"
        case 500 ... 531:
            return "cloud.rain"
        case 600 ... 622:
            return "cloud.snow"
        case 700 ... 781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802:
            return "cloud.sun"
        case 803:
            return "cloud.sun"
        case 804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
