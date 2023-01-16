//
//  PersistenceService.swift
//  WeatherHub
//
//  Created by Armando Brito on 15/1/23.
//

import Foundation

protocol Persistence {

    func addWeatherLocation(_ weatherLocation: WeatherByCityResponse) throws
    func getWeatherLocations() -> [WeatherByCityResponse]?
    func removeWeatherLocation(_ weatherLocation: WeatherByCityResponse) throws
    func removeAllWeatherLocations()

}

class PersistenceService: Persistence {

    private struct PersKey {
        static let weatherLocations = "weatherLocations"
    }

    private var userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func addWeatherLocation(_ weatherLocation: WeatherByCityResponse) throws {
        if var weatherLocations = getWeatherLocations() {
            weatherLocations.append(weatherLocation)
            try userDefaults.setObject(weatherLocations, forKey: PersKey.weatherLocations)
        } else {
            let newArray = [weatherLocation]
            try userDefaults.setObject(newArray, forKey: PersKey.weatherLocations)
        }
    }

    func getWeatherLocations() -> [WeatherByCityResponse]? {
        try? userDefaults.getObject(forKey: PersKey.weatherLocations)
    }

    func getWeatherLocations() throws -> [WeatherByCityResponse] {
        try userDefaults.getObject(forKey: PersKey.weatherLocations)
    }

    func removeWeatherLocation(_ weatherLocation: WeatherByCityResponse) throws {
        var weatherLocations: [WeatherByCityResponse] = try getWeatherLocations()
        if let index = weatherLocations.firstIndex(where: { $0.id == weatherLocation.id }) {
            weatherLocations.remove(at: index)
            try userDefaults.setObject(weatherLocations, forKey: PersKey.weatherLocations)
        }
    }

    func removeAllWeatherLocations() {
        userDefaults.set(nil, forKey: PersKey.weatherLocations)
    }

}
