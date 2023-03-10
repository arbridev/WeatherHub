//
//  PersistenceServiceMock.swift
//  WeatherHub
//
//  Created by Armando Brito on 17/1/23.
//

import Foundation

class PersistenceServiceMock: Persistence {

    enum State {
        case standard
        case emptyLocations
    }

    var state: State = .standard

    func addWeatherLocation(_ weatherLocation: WeatherLocation) throws {
        print("Tried to add a weather location to persistence")
        print(weatherLocation as AnyObject)
    }

    func getWeatherLocations() -> [WeatherLocation]? {
        var weatherLocations = [
            MockResponse.weatherByCityResponseBar,
            MockResponse.weatherByCityResponseGua
        ]
        if state == .emptyLocations {
            weatherLocations.removeAll()
        }
        return weatherLocations
    }

    func removeWeatherLocation(_ weatherLocation: WeatherLocation) throws {
        print("Tried to remove a weather location from persistence")
        print(weatherLocation as AnyObject)
    }

    func removeWeatherLocations(_ weatherLocations: [WeatherLocation]) throws {
        print("Tried to remove several weather locations from persistence")
        for (index, weatherLocation) in weatherLocations.enumerated() {
            print("\(index).", weatherLocation.name)
        }
    }

    func removeAllWeatherLocations() {
        print("Tried to remove a weather locations from persistence")
    }

}
