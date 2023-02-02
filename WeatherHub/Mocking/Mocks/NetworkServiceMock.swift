//
//  NetworkServiceMock.swift
//  WeatherHub
//
//  Created by Armando Brito on 12/1/23.
//

import Foundation
import Combine

class NetworkServiceMock: ExternalProvider {

    var responseDelay: TimeInterval

    init(responseDelay: TimeInterval = Constant.Mock.defaultNetworkResponseDelay) {
        self.responseDelay = responseDelay
    }

    func fetchWeatherByCity(withName city: String) -> AnyPublisher<WeatherLocation, Error> {
        print("\(self)", #function)
        let mock: WeatherLocation = MockResponse.weatherByCityResponseBar
        let mockPassthrough = PassthroughSubject<WeatherLocation, Error>()
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            mockPassthrough.send(mock)
        }
        return mockPassthrough.eraseToAnyPublisher()
    }

    func fetchWeather(fromCities cities: [String]) -> AnyPublisher<[WeatherLocation], Error> {
        print("\(self)", #function)
        let weatherLocations = [
            MockResponse.weatherByCityResponseBar,
            MockResponse.weatherByCityResponseGua,
            MockResponse.weatherByCityResponseBaires
        ]
        let mockPassthrough = PassthroughSubject<[WeatherLocation], Error>()
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            mockPassthrough.send(weatherLocations)
        }
        return mockPassthrough.eraseToAnyPublisher()
    }

}
