//
//  PersistenceService.swift
//  WeatherHub
//
//  Created by Armando Brito on 15/1/23.
//

import Foundation

protocol Persistence {

    func addWeatherLocation(_ weatherLocation: WeatherLocation) throws
    func getWeatherLocations() -> [WeatherLocation]?
    func removeWeatherLocation(_ weatherLocation: WeatherLocation) throws
    func removeWeatherLocations(_ weatherLocations: [WeatherLocation]) throws
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

    func addWeatherLocation(_ weatherLocation: WeatherLocation) throws {
        if var weatherLocations = getWeatherLocations() {
            weatherLocations.append(weatherLocation)
            try userDefaults.setObject(weatherLocations, forKey: PersKey.weatherLocations)
        } else {
            let newArray = [weatherLocation]
            try userDefaults.setObject(newArray, forKey: PersKey.weatherLocations)
        }
    }

    func getWeatherLocations() -> [WeatherLocation]? {
        try? userDefaults.getObject(forKey: PersKey.weatherLocations)
    }

    func getWeatherLocations() throws -> [WeatherLocation] {
        try userDefaults.getObject(forKey: PersKey.weatherLocations)
    }

    func removeWeatherLocation(_ weatherLocation: WeatherLocation) throws {
        var weatherLocations: [WeatherLocation] = try getWeatherLocations()
        if let index = weatherLocations.firstIndex(where: { $0.id == weatherLocation.id }) {
            weatherLocations.remove(at: index)
            try userDefaults.setObject(weatherLocations, forKey: PersKey.weatherLocations)
        }
    }

    func removeWeatherLocations(_ weatherLocations: [WeatherLocation]) throws {
        var old: [WeatherLocation] = try getWeatherLocations()
        removeAllWeatherLocations()
        let indicesToRemove = old.enumerated().compactMap { index, weatherLocation in
            weatherLocations.contains(weatherLocation) ? index : nil
        }
        old.remove(atOffsets: IndexSet(indicesToRemove))
        try userDefaults.setObject(old, forKey: PersKey.weatherLocations)
    }

    func removeAllWeatherLocations() {
        userDefaults.set(nil, forKey: PersKey.weatherLocations)
    }

}
