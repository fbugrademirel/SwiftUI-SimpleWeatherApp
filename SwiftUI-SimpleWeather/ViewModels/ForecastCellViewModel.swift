//
//  ForecastCellViewModel.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-19.
//

import Foundation

struct ForecastCellViewModel: Identifiable {
    
    let id = UUID()
    let imageString: String
    let temperature: String
    let date: String
    let windSpeed: String
    let windAngle: Int
    let windDirectionStringForSGIcon: String
    
}
