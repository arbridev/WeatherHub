//
//  NetworkServiceMock.swift
//  WeatherHub
//
//  Created by Armando Brito on 12/1/23.
//

import Foundation
import Combine

class NetworkServiceMock: ExternalProvider {

    var responseDelay: TimeInterval = 2.0

    init(responseDelay: TimeInterval) {
        self.responseDelay = responseDelay
    }

    func fetchWeatherByCity(withName city: String) -> AnyPublisher<WeatherLocation, Error> {
        let mock: WeatherLocation = MockResponse.weatherByCityResponseBar
        let mockPassthrough = PassthroughSubject<WeatherLocation, Error>()
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            mockPassthrough.send(mock)
        }
        return mockPassthrough.eraseToAnyPublisher()
    }

    func fetchWeather(fromCities cities: [String]) -> AnyPublisher<[WeatherLocation], Error> {
        let weatherLocations = [
            MockResponse.weatherByCityResponseBar,
            MockResponse.weatherByCityResponseGua
        ]
        let mockPassthrough = PassthroughSubject<[WeatherLocation], Error>()
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            mockPassthrough.send(weatherLocations)
        }
        return mockPassthrough.eraseToAnyPublisher()
    }

}
