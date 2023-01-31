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
                .font(.title)

            Text(weatherLocation.sys?.country ?? "")
                .font(.title3)

            VStack {
                Text("Location")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 4)
                if let coord = weatherLocation.coord {
                    HStack {
                        Text("Longitude:")
                            .fontWeight(.medium)
                        Text("\(coord.lon)")
                    }
                    HStack {
                        Text("Latitude:")
                            .fontWeight(.medium)
                        Text("\(coord.lat)")
                    }
                }
            }
            .padding(.top, 12)

            if let seaLevel = weatherLocation.main.seaLevel {
                HStack {
                    Text("Sea level:")
                        .font(.title3)
                        .fontWeight(.medium)
                    Text("\(Int(seaLevel)) meters")
                        .font(.title3)
                }
                .padding(.top, 24)
            }

            if let timezone = weatherLocation.timezone {
                HStack {
                    Text("Time zone:")
                        .fontWeight(.medium)
                    Text("\(timezone/3600) hours")
                }
                .padding(.top, 24)
            }
        }
    }
}

struct LocationDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockResponse.weatherByCityResponseBar
        LocationDescriptionView(weatherLocation: previewWeatherLocation)
    }
}
