//
//  ForecastView.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-19.
//

import SwiftUI

struct ForecastListView: View {
    
    let forecasts: [ForecastCellViewModel]
    let screenSize = UIScreen.main.bounds.size

    var body: some View {
        
        return VStack{
            
                Text("5 Day Forecasts")
                    .fontWeight(.ultraLight)
                    .font(.system(size: 24))
            
            ScrollView(showsIndicators: false ) {
                    ForEach(forecasts) { forecast in
                        ForecastCellView(forecast: forecast)
                            
                }
            }
            
        }.frame(width: screenSize.width)
        .foregroundColor(Color(UIColor.systemBackground))
        .background(Color.setAppColor(for: .forecast))
        .cornerRadius(20)
    }
}

struct ForecastCellView: View {
    
    let forecast: ForecastCellViewModel
    
    var body: some View {
        
        HStack(alignment: .center) {

            Spacer()
            
            Text(forecast.date)
                .fontWeight(.light)
                .font(.system(size: 12))
                .frame(maxWidth: .infinity)
                .lineLimit(1)
                .padding(.leading, 10)
            
            Text("\(forecast.temperature)°C")
                
                .font(.system(size: 24))
                .fontWeight(.light)
                .frame(maxWidth: .infinity)

            Image(systemName: forecast.imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: .center)
                .frame(maxWidth: .infinity)

            Text("\(forecast.windSpeed)km/h")
                .fontWeight(.light)
                .font(.system(size: 16))
                .frame(maxWidth: .infinity)
                .padding(.zero)
            
            Image(systemName: forecast.windDirectionStringForSGIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20, alignment: .center)
                .rotationEffect(Angle(degrees: Double(forecast.windAngle)))
                .padding(.trailing, 20)

            Spacer()

        }.foregroundColor(Color(UIColor.systemBackground))
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
