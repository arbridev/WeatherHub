//
//  HomeViewModel.swift
//  WeatherHub
//
//  Created by Armando Brito on 16/1/23.
//

import Foundation
import Combine

extension HomeView {

    @MainActor class ViewModel: ObservableObject {

        @Published private(set) var weatherLocations = [WeatherLocation]()
        @Published var isSelectingMore: Bool = false
        @Published var isPresentingAdd: Bool = false

        private let persistenceService: Persistence
        private let networkService: ExternalProvider
        private var cancellable: AnyCancellable?

        init(
            persistenceService: Persistence = PersistenceService(),
            networkService: ExternalProvider = NetworkService()
        ) {
            guard !LaunchArguments.shared.contains(.useMocks) else {
                self.persistenceService = PersistenceServiceMock()
                self.networkService = NetworkServiceMock()
                return
            }
            self.persistenceService = persistenceService
            self.networkService = networkService
        }

        func fetchWeatherLocations() {
            guard let persWeatherLocations = persistenceService.getWeatherLocations(),
                    !persWeatherLocations.isEmpty else {
                return
            }
            cancellable = networkService.fetchWeather(
                fromCities: persWeatherLocations.map({ $0.name })
            ).sink { completion in
                print("completed", #function)
            } receiveValue: { [weak self] weatherLocations in
                self?.weatherLocations = weatherLocations
            }
        }
    }

}
