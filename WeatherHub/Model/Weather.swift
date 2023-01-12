//
//  Weather.swift
//  WeatherHub
//
//  Created by Armando Brito on 12/1/23.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
