//
//  AddLocationViewModel.swift
//  WeatherHub
//
//  Created by Armando Brito on 19/1/23.
//

import Foundation
import Combine
import SwiftUI

extension AddLocationView {

    @MainActor class ViewModel: ObservableObject {

        @Published private(set) var weatherLocation: WeatherLocation?

        var mainData: AppData?
        private let persistenceService: Persistence
        private let networkService: ExternalProvider
        private var cancellables = Set<AnyCancellable>()
        private var debounceableCancellable: AnyCancellable?
        private var debounceablePublisher = PassthroughSubject<String, Never>()

        init(
            persistenceService: Persistence = PersistenceService(),
            networkService: ExternalProvider = NetworkService(shouldLog: false)
        ) {
            guard !LaunchArguments.shared.contains(.useMocks) else {
                self.persistenceService = PersistenceServiceMock()
                self.networkService = NetworkServiceMock()
                return
            }
            self.persistenceService = persistenceService
            self.networkService = networkService
        }

        func fetchWeatherLocation(withName name: String) {
            guard name.count > 1 else {
                return
            }
            debounceableCancellable = debounceablePublisher
                .debounce(for: .seconds(0.8), scheduler: DispatchQueue.main)
                .sink(receiveValue: { [weak self] text in
                    self?.fetchWeatherLocationDebounced(withName: text)
                })
            debounceablePublisher.send(name)
        }

        private func fetchWeatherLocationDebounced(withName name: String) {
            networkService.fetchWeatherByCity(withName: name)
                .catch({ error -> AnyPublisher<WeatherLocation, Never> in
                    let _ = print("catcherror", error)
                    return Empty(completeImmediately: true).eraseToAnyPublisher()
                })
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .failure(let error): print("Error \(error)")
                        case .finished: print("Publisher is finished")
                    }
                }, receiveValue: { [weak self] value in
                    dump(value)
                    self?.weatherLocation = value
                })
                .store(in: &cancellables)
        }

        func addLocation() {
            guard let weatherLocation else {
                return
            }
            try! persistenceService.addWeatherLocation(weatherLocation)
            mainData?.weatherLocations.append(weatherLocation)
        }

    }

}
