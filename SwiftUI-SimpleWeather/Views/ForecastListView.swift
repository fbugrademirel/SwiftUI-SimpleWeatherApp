//
//  ForecastView.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-19.
//

import SwiftUI

struct ForecastListView: View {
    
    let forecasts: [ForecastCellViewModel]

    var body: some View {
        
        List(self.forecasts, id:\.date) { forecast in
            ForecastCellView(forecast: forecast)
        }.mask(Rectangle().cornerRadius(25))
    }
}

struct ForecastCellView: View {
    
    let forecast: ForecastCellViewModel
    
    var body: some View {
        HStack {
            Text(forecast.date)
                .fontWeight(.light)
                .font(.system(size: 16))
                .padding(.zero)
            Text("\(forecast.temperature)°C")
                .font(.system(size: 20))
                .fontWeight(.light)
            Image(systemName: forecast.imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50, alignment: .center)
                .padding()
                .animation(.easeIn)
            Image(systemName: forecast.windDirectionStringForSGIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 40, alignment: .center)
                .rotationEffect(Angle(degrees: Double(forecast.windAngle)))
                .animation(.interpolatingSpring(stiffness: 10, damping: 1))
            Text("\(forecast.windSpeed)km/h")
                .fontWeight(.light)
                .font(.system(size: 20))
        }.foregroundColor(Color(UIColor.systemTeal))
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        return ForecastListView(forecasts:
                    [ForecastCellViewModel(imageString: "sun.max",
                                           temperature: "30",
                                           date: "12 May 18:00",
                                           windSpeed: "20",
                                           windAngle: 30,
                                           windDirectionStringForSGIcon: "arrow.up")])
    }
}