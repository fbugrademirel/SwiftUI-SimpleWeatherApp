//
//  CurrentWeatherViewModel.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import Foundation
import CoreLocation
import SwiftUI

final class CurrentWeatherViewModel: NSObject, ObservableObject {
    
    @Published var currentWeather: CurrentWeatherModel? = nil
    @Published var forecastCellViewModels = [ForecastCellViewModel]()

    var searchTerm: String = ""

    private var locationManager: CLLocationManager = {
            let lm = CLLocationManager()
            lm.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            return lm
    }()
    
    private var location: CLLocation? = nil {
        didSet {
            if let location = location {
                fetchWeather(for: .coordinates(location))
                fetchForecast(for: .coordinates(location))
            }
        }
    }
    
    
    func load() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func fetchAllWeather(by: WeatherDataAPI.LocationInformation) {
        if let cityName = self.searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeather(for: .cityName(cityName))
            fetchForecast(for: .cityName(cityName))
        }
    }
    
    private func fetchWeather(for location: WeatherDataAPI.LocationInformation) {
        
        WeatherDataAPI().getWeatherInfo(by: location) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.currentWeather = CurrentWeatherModel(id: data.id,
                                                              date: Date(timeIntervalSince1970: data.dt),
                                                              conditionID: data.weather[0].id,
                                                              conditionDescription: data.weather[0].description,
                                                              cityName: data.name,
                                                              windSpeedDouble: data.wind.speed,
                                                              windDirectionInt: data.wind.deg ?? 0,
                                                              temperatureDouble: data.main.temp)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchForecast(for location: WeatherDataAPI.LocationInformation) {
        WeatherDataAPI().getForecastWeatherInfo(by: location) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let forecastCellViewModels = data.list.map { (forecastWeatherData) -> ForecastCellViewModel in
                        let forecast = Forecast(date: Date(timeIntervalSince1970: forecastWeatherData.dt),
                                                temperatureDouble: forecastWeatherData.main.temp,
                                                conditionID: forecastWeatherData.weather[0].id,
                                                windSpeed: forecastWeatherData.wind.speed,
                                                windDirection: forecastWeatherData.wind.deg ?? 0)
                    
                        let vm = ForecastCellViewModel(imageString: forecast.conditionNameForSFIcons,
                                                       temperature: forecast.temperatureString,
                                                       date: forecast.dateString,
                                                       windSpeed: forecast.windSpeedString,
                                                       windAngle: forecast.windDirection,
                                                       windDirectionStringForSGIcon: forecast.windDirectionStringForSFImage)
                        
                        return vm
                    }
                    self.forecastCellViewModels = forecastCellViewModels
                }
                
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

//MARK: - Location Manager
extension CurrentWeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


