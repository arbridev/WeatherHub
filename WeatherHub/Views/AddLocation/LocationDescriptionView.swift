//
//  LocationDescriptionView.swift
//  WeatherHub
//
//  Created by Armando Brito on 15/1/23.
//

import SwiftUI

struct LocationDescriptionView: View {
    
    var weatherLocation: WeatherLocation

    var body: some View {
        VStack {
            Text(weatherLocation.name)
                .font(.title2)

            Text(weatherLocation.sys.country)
                .font(.title3)

            VStack {
                Text("Location")
                    .font(.title3)
                    .bold()
                Text("Longitude: \(weatherLocation.coord.lon)")
                Text("Latitude: \(weatherLocation.coord.lat)")
            }
            .padding(.top, 4)

            if let seaLevel = weatherLocation.main.seaLevel {
                Text("Sea level: \(Int(seaLevel)) meters")
                    .font(.title3)
                    .padding(.top, 24)
            }

            Text("Time zone: \(weatherLocation.timezone/3600) hours")
                .padding(.top, 24)
        }
    }
}

struct LocationDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockResponse.weatherByCityResponseBar
        LocationDescriptionView(weatherLocation: previewWeatherLocation)
    }
}
