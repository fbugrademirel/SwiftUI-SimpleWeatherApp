//
//  CurrentWeatherViewModel.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import Foundation

final class CurrentWeatherViewModel: ObservableObject {
    
    @Published var currentWeather: CurrentWeatherModel? = nil
    var cityName: String? = nil
    
    func load() {
        if let cityName = cityName {
            fetchWeather(by: cityName)
        }
    }
    
    
    private func fetchWeather(by cityName: String) {
        
        WeatherDataAPI().getWeatherInfo(by: cityName) { [weak self] result in
            guard let self = self else {return}
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
}

