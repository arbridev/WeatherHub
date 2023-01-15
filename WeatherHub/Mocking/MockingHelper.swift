//
//  MockingHelper.swift
//  WeatherHub
//
//  Created by Armando Brito on 12/1/23.
//

import Foundation

struct MockingHelper {

    static var weatherByCityResponse: WeatherByCityResponse {
        MockingHelper.parseJSON(fromFileWithName: "weather-by-city")
    }

    static var weatherByCityResponseGua: WeatherByCityResponse {
        MockingHelper.parseJSON(fromFileWithName: "weather-by-city-gua")
    }

    static func parseJSON<T: Decodable>(fromFileWithName fileName: String) -> T {
        var decodedObject: T!
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                decodedObject = try JSONDecoder().decode(T.self, from: data)
            } catch {
                fatalError("Could not parse JSON file (\(fileName)) for \(T.self).\n\(error)")
            }
        }
        return decodedObject
    }

}
