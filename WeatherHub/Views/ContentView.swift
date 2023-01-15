//
//  ContentView.swift
//  WeatherHub
//
//  Created by Armando Brito on 6/12/22.
//

import SwiftUI

struct ContentView: View {

    let weatherLocations = [
        MockingHelper.weatherByCityResponse,
        MockingHelper.weatherByCityResponseGua
    ]

    var body: some View {
        HomeView(weatherLocations: weatherLocations)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
