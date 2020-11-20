//
//  ContentView.swift
//  SwiftUI-SimpleWeather
//
//  Created by Faruk Buğra DEMIREL on 2020-11-18.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = CurrentWeatherViewModel()
    @State private var viewState = CGSize.zero
    
    init() {
        self.viewModel.load()
    }

    var body: some View {
        
        NavigationView {
        
            ZStack {
                VStack {
                    searchView()
                    ScrollView(showsIndicators: false) {
                        if let model = self.viewModel.currentWeather {
                            CurrentWeatherView(viewModel: model)
                        }
                    }.animation(.easeIn(duration: 0.2))
                }
                .background(Color(UIColor.lightGray))
                .mask(Rectangle().cornerRadius(20))
                .animation(.spring())
                .offset(y:viewState.height > 100 ? 30 : 60)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    self.viewState = .zero
                })
                
                ForecastListView(forecasts: viewModel.forecastCellViewModels)
                    .navigationBarHidden(true)
                    .offset(y: viewState.height + 400)
                    .animation(.spring())
                    .gesture(DragGesture()
                            .onChanged({ (value) in
                                self.viewState = value.translation
                            })
                            .onEnded({ (value) in
                                if self.viewState.height > 200 {
                                    self.viewState = CGSize(width: 0, height: 800)
                                } else if self.viewState.height < 100 {
                                    self.viewState = CGSize(width: 0, height: 0)
                                }
                            }))
            }.edgesIgnoringSafeArea(.all)
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
