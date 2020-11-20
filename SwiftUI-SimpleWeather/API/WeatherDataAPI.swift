//
//  WeatherDataAPI.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import Foundation
import CoreLocation

private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=0a4f004ec035e586cf9fa1bff7bb191d&units=metric&q="
private let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?appid=0a4f004ec035e586cf9fa1bff7bb191d&units=metric&q="

struct WeatherDataAPI {
        
    private let networkingService = NetworkingService()
    
    func getWeatherInfo(by locationInformation: LocationInformation, with completion: @escaping (Result<CurrentWeatherData,Error>) -> Void) {
        
        let url = setURL(locationInformation: locationInformation, forecastType: .current)
            
        networkingService.dispatchRequest(urlString: url, method: .get) { result in
    
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(CurrentWeatherData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(weather))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getForecastWeatherInfo(by locationInformation: LocationInformation, completion: @escaping ((Result<ForecastData, Error>) -> Void)) {

        let url = setURL(locationInformation: locationInformation, forecastType: .fiveDays)

            networkingService.dispatchRequest(urlString: url, method: .get) { result in
                switch result {
                case .success(let data):
                    do {
                        let weather = try JSONDecoder().decode(ForecastData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(weather))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
}

//MARK: - Extension
extension WeatherDataAPI {
    
    enum LocationInformation {
        case coordinates(CLLocation)
        case cityName(String)
    }
    
    enum ForecastType {
            case current
            case fiveDays
        }
    
    private func setURL(locationInformation: LocationInformation, forecastType: ForecastType) -> String {

            var url = ""

            switch (locationInformation, forecastType) {
            case (.cityName(let cityName), .current):
                url = "\(weatherURL)\(cityName)"
            case (.cityName(let cityName), .fiveDays):
                url = "\(forecastURL)\(cityName)"
            case (.coordinates(let location), .current):
                url = "\(weatherURL)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
            case (.coordinates(let location), .fiveDays):
                url = "\(forecastURL)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
            }
            return url
        }
}
