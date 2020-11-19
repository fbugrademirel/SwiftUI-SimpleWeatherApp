//
//  CurrentWeatherView.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-19.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    let viewModel: CurrentWeatherModel
        
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 5) {
            
            Text(viewModel.cityName)
                .fontWeight(.light)
                .font(.system(size: 32))
                .padding(.trailing, 20)

            Image(systemName: viewModel.conditionNameForSFIcons)
                .resizable()
                .frame(width: 100, height: 100)
                .padding(20)
            
            Text(viewModel.dateString)
                .fontWeight(.light)
                .font(.system(size: 20))
                .padding(.trailing, 20)
            
            HStack(alignment: .center, spacing: 0) {
                
                Spacer()
                
                Text(viewModel.temperatureString)
                    .fontWeight(.light)
                    .font(.system(size: 60))
                    .padding(.trailing, 0)
                
                Text("°C")
                    .fontWeight(.light)
                    .font(.system(size: 60))
                    .padding(.leading, 0)
                    .padding(.trailing, 20)
            }
            
            Spacer()
            
        }.foregroundColor(.blue)
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        //Dummy model for preview
        CurrentWeatherView(viewModel: CurrentWeatherModel(id: 0, date: Date(), conditionID: 600, conditionDescription: "Cloudy", cityName: "Stockholm", windSpeedDouble: 14.00, windDirectionInt: 50, temperatureDouble: 15))
    }
}

//viewModel.currentWeather?.conditionNameForSFIcons
