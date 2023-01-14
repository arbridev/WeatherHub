//
//  WeatherHubTests.swift
//  WeatherHubTests
//
//  Created by Armando Brito on 11/12/22.
//

import XCTest
import Combine
@testable import WeatherHub

class WeatherHubTests: XCTestCase {

    var networkService: NetworkService!
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        networkService = NetworkServiceMock(responseDelay: 2.0)
    }

    func testFetchWeatherByCity() throws {
        let expectation = XCTestExpectation()
        let cityName = "Barquisimeto"
        let countryCode = "VE"

        cancellable = networkService.fetchWeatherByCity(withName: cityName)
            .sink(receiveCompletion: { completion in

            }, receiveValue: { response in
                print(response as AnyObject)
                XCTAssertTrue(response.name == cityName)
                XCTAssertTrue(response.sys.country == countryCode)
                expectation.fulfill()
            })

        wait(for: [expectation], timeout: 5.0, enforceOrder: false)
    }

}
