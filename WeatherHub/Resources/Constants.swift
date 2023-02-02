//
//  Constants.swift
//  WeatherHub
//
//  Created by Armando Brito on 6/12/22.
//

import Foundation

struct Constant {

    private init() {}

    static let apiRoot = "https://api.openweathermap.org/data/2.5"
    static let searchQueryMinimum = 2

    static var apiKey: String {
        Bundle.main.infoDictionary!["API_KEY"] as! String
    }

    struct Mock {
        private init() {}

        static let defaultNetworkResponseDelay = TimeInterval(2.0)
    }

}
