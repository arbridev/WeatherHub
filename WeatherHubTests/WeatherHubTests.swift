//
//  WeatherHubTests.swift
//  WeatherHubTests
//
//  Created by Armando Brito on 11/12/22.
//

import XCTest
@testable import WeatherHub

class WeatherHubTests: XCTestCase {

    func testConstants() throws {
        XCTAssertEqual(Constant.apiKey, "some_api_key")
    }

}
