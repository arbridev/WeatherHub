//
//  NetworkServiceMock.swift
//  WeatherHub
//
//  Created by Armando Brito on 12/1/23.
//

import Foundation
import Combine

class NetworkServiceMock: NetworkService {

    var responseDelay: TimeInterval = 2.0

    init(responseDelay: TimeInterval) {
        self.responseDelay = responseDelay
    }

    func fetchWeatherByCity(withName city: String) -> AnyPublisher<WeatherByCityResponse, Error> {
        let mock: WeatherByCityResponse = MockingHelper.parseJSON(fromFileWithName: "weather-by-city")
        let mockPassthrough = PassthroughSubject<WeatherByCityResponse, Error>()
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            mockPassthrough.send(mock)
        }
        return mockPassthrough.eraseToAnyPublisher()
    }

}
