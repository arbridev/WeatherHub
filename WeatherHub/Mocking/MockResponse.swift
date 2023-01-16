//
//  MockResponse.swift
//  WeatherHub
//
//  Created by Armando Brito on 16/1/23.
//

import Foundation

struct MockResponse {

    private init() {}

    static var weatherByCityResponseBar: WeatherLocation {
        MockingHelper.parseJSON(fromFileWithName: "weather-by-city-bar")
    }

    static var weatherByCityResponseGua: WeatherLocation {
        MockingHelper.parseJSON(fromFileWithName: "weather-by-city-gua")
    }

}
