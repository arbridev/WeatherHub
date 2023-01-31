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
        
        @Published var mainData: AppData?
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
                self?.mainData?.weatherLocations = weatherLocations
            }
        }

        func removeWeatherLocations(fromIndices indices: IndexSet) {
            let forRemoval = mainData!.weatherLocations.enumerated().compactMap { index, weatherLocation in
                indices.contains(index) ? weatherLocation : nil
            }
            try? persistenceService.removeWeatherLocations(forRemoval)
            mainData?.weatherLocations.remove(atOffsets: indices)
        }
    }

}
