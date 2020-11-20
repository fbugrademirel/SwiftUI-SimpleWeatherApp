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
        
        VStack(alignment: .trailing, spacing: 0) {
        
            Text(viewModel.cityName)
                .fontWeight(.light)
                .font(.system(size: 32))

            Text("\(viewModel.temperatureString)°C" )
                .fontWeight(.light)
                .font(.system(size: 60))
                
            HStack {
                
                Spacer()
                
                VStack {
                    Image(systemName: viewModel.windDirectionStringForSFImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .rotationEffect(Angle(degrees: Double(viewModel.windDirectionInt)))
                        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
                    Text("\(viewModel.windSpeedString)km/h")
                        .padding()
                }
                
                Image(systemName: viewModel.conditionNameForSFIcons)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150,height: 150, alignment: .center)
                    .padding()
                    .animation(.easeIn)
            }
            
            Text(viewModel.dateString)
                .fontWeight(.light)
                .font(.system(size: 20))
    
            Spacer()
        }.foregroundColor(Color(UIColor.systemTeal)).padding()
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        //Dummy model for preview
        CurrentWeatherView(viewModel: CurrentWeatherModel(id: 0, date: Date(), conditionID: 600, conditionDescription: "Cloudy", cityName: "Stockholm", windSpeedDouble: 14.00, windDirectionInt: 50, temperatureDouble: 15))
    }
}
