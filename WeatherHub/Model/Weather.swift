//
//  Weather.swift
//  WeatherHub
//
//  Created by Armando Brito on 12/1/23.
//

import Foundation

// MARK: - Weather
struct Weather: Codable, Hashable {
    let id: Int
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable, Hashable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
