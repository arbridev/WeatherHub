//
//  LaunchArguments.swift
//  WeatherHub
//
//  Created by Armando Brito on 16/1/23.
//

import Foundation

enum LaunchArgument: String {
    case useMocks = "-useMocks"
}

class LaunchArguments {

    static var shared = LaunchArguments()

    private init() {}

    func contains(_ launchArgument: LaunchArgument) -> Bool {
        CommandLine.arguments.contains(launchArgument.rawValue)
    }

    func contains(_ launchArguments: [LaunchArgument]) -> Bool {
        if #available(iOS 16.0, *) {
            return CommandLine.arguments.contains(launchArguments.map({ $0.rawValue }))
        } else {
            for launchArgument in launchArguments {
                if !contains(launchArgument) {
                    return false
                }
            }
            return true
        }
    }

}
