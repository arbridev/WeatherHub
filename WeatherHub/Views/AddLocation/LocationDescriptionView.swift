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
                .foregroundColor(Color.Custom.Font.darkContrast)

            Text(weatherLocation.sys?.country ?? "")
                .font(.title3)
                .foregroundColor(Color.Custom.Font.darkContrast)

            VStack {
                Text("Location")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.Custom.Font.darkContrast)
                    .padding(.bottom, 4)
                if let coord = weatherLocation.coord {
                    HStack {
                        Text("Longitude:")
                            .fontWeight(.medium)
                            .foregroundColor(Color.Custom.Font.darkContrast)
                        Text("\(coord.lon)")
                            .foregroundColor(Color.Custom.Font.darkContrast)
                    }
                    HStack {
                        Text("Latitude:")
                            .fontWeight(.medium)
                            .foregroundColor(Color.Custom.Font.darkContrast)
                        Text("\(coord.lat)")
                            .foregroundColor(Color.Custom.Font.darkContrast)
                    }
                }
            }
            .padding(.top, 12)

            if let seaLevel = weatherLocation.main.seaLevel {
                HStack {
                    Text("Sea level:")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.Custom.Font.darkContrast)
                    Text("\(Int(seaLevel)) meters")
                        .font(.title3)
                        .foregroundColor(Color.Custom.Font.darkContrast)
                }
                .padding(.top, 24)
            }

            if let timezone = weatherLocation.timezone {
                HStack {
                    Text("Time zone:")
                        .fontWeight(.medium)
                        .foregroundColor(Color.Custom.Font.darkContrast)
                    Text("\(timezone/3600) hours")
                        .foregroundColor(Color.Custom.Font.darkContrast)
                }
                .padding(.top, 24)
            }
        }
        .background(Color.Custom.primary)
    }
}

struct LocationDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockResponse.weatherByCityResponseBar
        LocationDescriptionView(weatherLocation: previewWeatherLocation)
    }
}
