//
//  Extension+Color.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-20.
//

import SwiftUI

extension Color {
    
    enum AppColor {
        case current
        case forecast
    }
    
    static func setAppColor(for color: AppColor) -> Color {
        
        switch color {
        case .current:
            return Color(UIColor.init(named: "CurrentWeatherViewBackground")!)
        case .forecast:
            return Color(UIColor.init(named: "ForecastViewBackground")!)
        }
    }
}
