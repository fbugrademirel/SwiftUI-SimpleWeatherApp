//
//  ContentView.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cityName: String = ""
    @ObservedObject private var viewModel = CurrentWeatherViewModel()
    
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .trailing, spacing: 5) {
                    
                    SearchView(cityName: $cityName)
                    
                    Text("City Name")
                        .fontWeight(.light)
                        .font(.system(size: 32))
                        .padding(.trailing, 20)

                    Image(systemName: "\(viewModel.currentWeather?.conditionNameForSFIcons ?? "sun.max")")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(20)
                    
                    Text("Date")
                        .fontWeight(.light)
                        .font(.system(size: 32))
                        .padding(.trailing, 20)
                    
                    HStack(alignment: .center, spacing: 0) {
                        
                        Spacer()
                        
                        Text("TEMP")
                            .fontWeight(.light)
                            .font(.system(size: 32))
                            .padding(.trailing, 0)
                        
                        Text("°C")
                            .fontWeight(.light)
                            .font(.system(size: 32))
                            .padding(.leading, 0)
                            .padding(.trailing, 20)
                    }
                    
                    Spacer()
                    
                }.foregroundColor(.blue)
                
            }
            
        }.navigationBarTitle("Current Weather", displayMode: .inline)
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

