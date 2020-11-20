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

struct FiveDayForecastModel {
        let forecastList: [Forecast]
        let cityName: String
    }

    struct Forecast {
        let date: Date
        var dateString: String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = "dd MMM HH:mm"
            return dateFormatter.string(from: date)
        }
        let temperatureDouble: Double
        var temperatureString: String {
            return String(format: "%.0f", temperatureDouble)
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

struct CommonWeatherModelOpearaions {
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
