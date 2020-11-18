//
//  Weather.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import Foundation

struct ForecastData: Decodable {
        let list: [ForecastWeatherData]
    }

    struct ForecastWeatherData: Decodable {
        let dt: Double
        let main: Main
        let weather: [Weather]
        let wind: Wind
    }

    struct CurrentWeatherData: Decodable {
        let coord: Coord
        let dt: Double
        let name: String
        let id: Int
        let main: Main
        let weather: [Weather]
        let wind: Wind
    }

    struct Main: Decodable {
        let temp: Double
    }

    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int?
    }

    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }
