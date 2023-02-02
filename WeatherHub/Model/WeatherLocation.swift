//
//  WeatherLocation.swift
//  WeatherHub
//
//  Created by Armando Brito on 12/1/23.
//

import Foundation

// MARK: - WeatherLocation
struct WeatherLocation: Codable, Hashable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable, Hashable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable, Hashable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable, Hashable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    let seaLevel: Int?
    let grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable, Hashable {
    let country: String
    let sunrise, sunset: Int
}
