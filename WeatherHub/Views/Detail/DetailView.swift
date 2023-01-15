//
//  DetailView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct DetailView: View {

    var weatherLocation: WeatherByCityResponse

    var body: some View {
        VStack {
            Text(weatherLocation.name)
                .font(.title2)

            Text(weatherLocation.sys.country)
                .font(.title3)

            Text("\(Int(weatherLocation.main.temp)) K")
                .font(.title3)
                .padding(.top, 24)

            HStack {
                Text("Min: \(Int(weatherLocation.main.tempMin)) K")
                Text("/")
                Text("Max: \(Int(weatherLocation.main.tempMax)) K")
            }
            .padding(.top, 4)

            Text(weatherLocation.weather.first?.main ?? "")
                .padding(.top, 24)
        }
        .navigationTitle("Weather Location")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockingHelper.weatherByCityResponse
        DetailView(weatherLocation: previewWeatherLocation)
    }
}
