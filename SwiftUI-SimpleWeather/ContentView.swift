//
//  ContentView.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = CurrentWeatherViewModel()
    @State private var scrollOffset = CGPoint()
    
    init() {
        self.viewModel.load()
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }

    var body: some View {
        
        NavigationView {
        
            VStack {
                searchView()
                ScrollView(showsIndicators: false) {
                    if let model = self.viewModel.currentWeather {
                        CurrentWeatherView(viewModel: model)
                    }
                }.animation(.easeOut(duration: 0.2))
                Text("5 Days Forecast")
                    .padding(.zero)
                    .foregroundColor(Color(UIColor.systemTeal))
                    .font(.system(size: 20))
                ForecastListView(forecasts: viewModel.forecastCellViewModels)
                    .navigationBarHidden(true)
            }
        }
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
                viewModel.fetchAllWeather(by: .cityName(viewModel.searchTerm))
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
