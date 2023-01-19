//
//  PersistenceServiceMock.swift
//  WeatherHub
//
//  Created by Armando Brito on 17/1/23.
//

import Foundation

class PersistenceServiceMock: Persistence {

    func addWeatherLocation(_ weatherLocation: WeatherLocation) throws {
        print("Tried to add a weather location to persistence")
        print(weatherLocation as AnyObject)
        return
    }

    func getWeatherLocations() -> [WeatherLocation]? {
        let weatherLocations = [
            MockResponse.weatherByCityResponseBar,
            MockResponse.weatherByCityResponseGua
        ]
        return weatherLocations
    }

    func removeWeatherLocation(_ weatherLocation: WeatherLocation) throws {
        print("Tried to remove a weather location from persistence")
        print(weatherLocation as AnyObject)
        return
    }

    func removeAllWeatherLocations() {
        print("Tried to remove a weather locations from persistence")
        return
    }

}