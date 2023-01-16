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

    func testPersistence() throws {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            XCTFail("No bundle identifier")
            return
        }
        let userDefaults = UserDefaults(suiteName: "test_\(bundleIdentifier)")
        let persistenceService: Persistence = PersistenceService()
        persistenceService.removeAllWeatherLocations()
        XCTAssertNil(persistenceService.getWeatherLocations())
        let weatherLocation = MockingHelper.weatherByCityResponse
        try persistenceService.addWeatherLocation(weatherLocation)
        XCTAssertTrue(persistenceService.getWeatherLocations()?.count == 1)
        try persistenceService.removeWeatherLocation(weatherLocation)
        XCTAssertTrue(persistenceService.getWeatherLocations()!.isEmpty)
    }

}
