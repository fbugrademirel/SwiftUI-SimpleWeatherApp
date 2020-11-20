//
//  ForecastModel.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-20.
//

import Foundation

struct FiveDayForecastModel {
        let forecastList: [Forecast]
        let cityName: String
    }

    struct Forecast {
        let date: Date
        var dateString: String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = "dd | HH:mm"
            return dateFormatter.string(from: date)
        }
        let temperatureDouble: Double
        var temperatureString: String {
            let str = String(format: "%.0f", temperatureDouble)
            if str == "-0" {
                return "0"
            } else {
                return str
            }
        }
        let conditionID: Int
        var conditionNameForSFIcons: String {
            CommonWeatherModelOpearaions.getSFIconsForWeatherCondition(conditionID)
        }
        let windSpeed: Double
        var windSpeedString: String {
            return String(format: "%.0f", windSpeed * 3.6) // in km/h
        }
        let windDirection: Int
        let windDirectionStringForSFImage = "arrow.up"
    }
