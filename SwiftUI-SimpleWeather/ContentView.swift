//
//  ContentView.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = CurrentWeatherViewModel()
    
    init() {
        self.viewModel.load()
    }

    var body: some View {
        
        if !viewModel.searchTerm.isEmpty {
            viewModel.fetchCurrentWeather(by: viewModel.searchTerm)
        }
        
        return NavigationView {
            
            VStack {
            
                SearchView(cityName: self.$viewModel.searchTerm)
                ScrollView {
                    if let model = self.viewModel.currentWeather {
                        CurrentWeatherView(viewModel: model)
                    }
                    Spacer()
                }
                
                Spacer()
            }
            
        }.navigationBarTitle("Current Weather", displayMode: .inline)
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

