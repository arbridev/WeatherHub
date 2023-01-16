//
//  LocationWeatherRowView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct LocationWeatherRowView: View {

    var weatherLocation: WeatherLocation

    var body: some View {
        HStack {
            Text(weatherLocation.name)
            Spacer()
            Text(weatherLocation.weather.last?.main ?? "")
            Text("\(Int(weatherLocation.main.temp)) K")
        }
        .padding()
    }
}

struct LocationWeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockResponse.weatherByCityResponseBar
        LocationWeatherRowView(weatherLocation: previewWeatherLocation)
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
