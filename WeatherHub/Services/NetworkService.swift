//
//  NetworkService.swift
//  WeatherHub
//
//  Created by Armando Brito on 6/12/22.
//

import Foundation
import Combine

protocol ExternalProvider {

    func fetchWeatherByCity(withName city: String) -> AnyPublisher<WeatherLocation, Error>
    func fetchWeather(fromCities cities: [String]) -> AnyPublisher<[WeatherLocation], Error>

}

class NetworkService: ExternalProvider {

    private var session: URLSession!

    init(shouldLog: Bool = false) {
        self.session = shouldLog ?
        URLSession(configuration: HTTPLogger.defaultSessionConfiguration) :
        URLSession.shared
    }
    
    func fetchWeatherByCity(withName city: String) -> AnyPublisher<WeatherLocation, Error> {
        let url = URL.fetchByCity(withName: city)
        return session.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: WeatherLocation.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchWeather(fromCities cities: [String]) -> AnyPublisher<[WeatherLocation], Error> {
        let publishers = cities.map { city in
            fetchWeatherByCity(withName: city)
        }
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
}

fileprivate extension URL {

    struct QueryComponent {
        let field: String
        let value: String
    }

    static func fetchByCity(withName city: String) -> URL {
        let usesMetric = NSLocale().usesMetricSystem
        return makeForEndpoint(
            "/weather",
            queryComponents: QueryComponent(field: "q", value: city),
            QueryComponent(field: "appid", value: Constant.apiKey),
            QueryComponent(field: "units", value: usesMetric ? "metric" : "imperial")
        )
    }

    static func makeForEndpoint(_ endpoint: String) -> URL {
        URL(string: "\(Constant.apiRoot)\(endpoint)")!
    }

    static func makeForEndpoint(_ endpoint: String, queryComponents: QueryComponent...) -> URL {
        var endpointAndQuery = endpoint
        if queryComponents.count > 0 {
            endpointAndQuery.append("?")
        }
        for (index, qComponent) in queryComponents.enumerated() {
            endpointAndQuery.append("\(qComponent.field)=\(qComponent.value)")
            if index < queryComponents.count - 1 {
                endpointAndQuery.append("&")
            }
        }
        return makeForEndpoint(endpointAndQuery)
    }

}
