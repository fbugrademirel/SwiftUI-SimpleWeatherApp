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
        
        NavigationView {
            
            VStack {
            
                searchView()
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

extension ContentView {
    fileprivate func searchView() -> some View {
        return HStack {
            
            Spacer()
            
            Image(systemName: "magnifyingglass")
            
            TextField("Search for city...", text: $viewModel.searchTerm, onCommit: {
                viewModel.fetchCurrentWeather(by: .cityName(viewModel.searchTerm))
            })
            .foregroundColor(.primary)
            .padding(10)
            Spacer()
        }.foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(10)
    }
}
