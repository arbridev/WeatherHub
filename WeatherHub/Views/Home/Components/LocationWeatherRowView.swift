//
//  LocationWeatherRowView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct LocationWeatherRowView: View {

    var weatherLocation: WeatherLocation
    var temperatureSymbol: String {
        let usesMetric = NSLocale.current.measurementSystem == .metric
        return usesMetric ? "℃" : "℉"
    }
    var weatherStatus: WeatherStatus {
        WeatherStatus(rawValue: weatherLocation.weather?.first?.main ?? "") ?? .unknown
    }
    var backgroundColor: Color {
        switch weatherStatus {
            case .clear:
                return Color.Custom.Weather.clear
            case .clouds:
                return Color.Custom.Weather.clouds
            case .rain:
                return Color.Custom.Weather.rain
            case .snow:
                return Color.Custom.Weather.snow
            case .extreme:
                return Color.Custom.Weather.extreme
            default:
                return Color.Custom.Weather.unknown
        }
    }

    var body: some View {
        ZStack {
            backgroundColor
            HStack {
                Text(weatherLocation.name)
                    .fontWeight(.medium)
                    .foregroundColor(Color.Custom.Font.darkContrast)
                Spacer()

                switch weatherStatus {
                    case .clear:
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                            .foregroundColor(Color.Custom.WeatherIcon.clear)
                    case .clouds:
                        Image(systemName: "cloud.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                            .foregroundColor(Color.Custom.WeatherIcon.clouds)
                    case .rain:
                        Image(systemName: "cloud.drizzle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                            .foregroundColor(Color.Custom.WeatherIcon.rain)
                    case .snow:
                        Image(systemName: "cloud.snow.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                            .foregroundColor(Color.Custom.WeatherIcon.snow)
                    case .extreme:
                        Image(systemName: "cloud.bolt.rain.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                            .foregroundColor(Color.Custom.WeatherIcon.extreme)
                    default:
                        Image(systemName: "questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                            .foregroundColor(Color.Custom.WeatherIcon.unknown)
                }

                Text("\(Int(weatherLocation.main.temp)) \(temperatureSymbol)")
                    .fontWeight(.medium)
                    .foregroundColor(Color.Custom.Font.darkContrast)
            }
            .padding()
        }
    }
    
}

struct LocationWeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockResponse.weatherByCityResponseBar
        LocationWeatherRowView(weatherLocation: previewWeatherLocation)
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
