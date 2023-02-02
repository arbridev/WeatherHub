//
//  DetailView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct DetailView: View {

    var weatherLocation: WeatherLocation
    var temperatureSymbol: String {
        let usesMetric = NSLocale.current.measurementSystem == .metric
        return usesMetric ? "℃" : "℉"
    }
    var speedSymbol: String {
        let usesMetric = NSLocale.current.measurementSystem == .metric
        return usesMetric ? "kmh" : "mph"
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

            VStack {
                Text(weatherLocation.name)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color.Custom.Font.darkContrast)

                Text(weatherLocation.sys?.country ?? "")
                    .font(.title3)
                    .foregroundColor(Color.Custom.Font.darkContrast)

                Text("\(Int(weatherLocation.main.temp)) \(temperatureSymbol)")
                    .font(.title3)
                    .foregroundColor(Color.Custom.Font.darkContrast)
                    .padding(.top, 12)
                Text("Feels like \(Int(weatherLocation.main.feelsLike)) \(temperatureSymbol)")
                    .font(.title3)
                    .foregroundColor(Color.Custom.Font.darkContrast)

                HStack {
                    HStack {
                        Text("Min:")
                            .fontWeight(.medium)
                            .foregroundColor(Color.Custom.Font.darkContrast)
                        Text("\(Int(weatherLocation.main.tempMin)) \(temperatureSymbol)")
                            .foregroundColor(Color.Custom.Font.darkContrast)
                    }
                    Text("/")
                        .foregroundColor(Color.Custom.Font.darkContrast)
                    HStack {
                        Text("Max:")
                            .fontWeight(.medium)
                            .foregroundColor(Color.Custom.Font.darkContrast)
                        Text("\(Int(weatherLocation.main.tempMax)) \(temperatureSymbol)")
                            .foregroundColor(Color.Custom.Font.darkContrast)
                    }
                }

                HStack {
                    Text("Humidity:")
                        .fontWeight(.medium)
                        .foregroundColor(Color.Custom.Font.darkContrast)

                    Text("\(Int(weatherLocation.main.humidity))%")
                        .foregroundColor(Color.Custom.Font.darkContrast)
                }
                .padding(.top, 4)

                IconView(weatherStatus: weatherStatus)
                    .frame(
                        width: UIScreen.main.bounds.size.width/2,
                        height: UIScreen.main.bounds.size.height/4,
                        alignment: .center)
                    .padding(.top, 24)

                if let weatherDescription = weatherLocation.weather?.first?.description {
                    Text("There is currently \(weatherDescription) in this area.")
                        .foregroundColor(Color.Custom.Font.darkContrast)
                        .padding()
                }

                if let windSpeed = weatherLocation.wind?.speed {
                    HStack {
                        Text("Wind speed:")
                            .fontWeight(.medium)
                            .foregroundColor(Color.Custom.Font.darkContrast)

                        Text("\(Int(windSpeed)) \(speedSymbol)")
                            .foregroundColor(Color.Custom.Font.darkContrast)
                    }
                    .padding(.top, 4)
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Weather Location")
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockResponse.weatherByCityResponseBaires
        DetailView(weatherLocation: previewWeatherLocation)
    }
}

fileprivate struct IconView: View {
    var weatherStatus: WeatherStatus

    var body: some View {
        switch weatherStatus {
            case .clear:
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.Custom.WeatherIcon.clear)
            case .clouds:
                Image(systemName: "cloud.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.Custom.WeatherIcon.clouds)
            case .rain:
                Image(systemName: "cloud.drizzle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.Custom.WeatherIcon.rain)
            case .snow:
                Image(systemName: "cloud.snow.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.Custom.WeatherIcon.snow)
            case .extreme:
                Image(systemName: "cloud.bolt.rain.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.Custom.WeatherIcon.extreme)
            default:
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.Custom.WeatherIcon.unknown)
        }
    }
}
