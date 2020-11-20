//
//  CurrentWeatherModel.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import Foundation

struct CurrentWeatherModel {
    let id: Int
    let date: Date
    let conditionID: Int
    let conditionDescription: String
    let cityName: String
    let windSpeedDouble: Double
    var windSpeedString: String {
       return String(format: "%.0f", windSpeedDouble * 3.6) // in km/h
    }
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd MMM HH:mm"
        return dateFormatter.string(from: date)
    }
    let windDirectionInt: Int
    let windDirectionStringForSFImage = "arrow.up"
    let temperatureDouble: Double
    var temperatureString: String {
       return String(format: "%.0f", temperatureDouble)
    }

    var conditionNameForSFIcons: String {
       CommonWeatherModelOpearaions.getSFIconsForWeatherCondition(conditionID)
    }
}
