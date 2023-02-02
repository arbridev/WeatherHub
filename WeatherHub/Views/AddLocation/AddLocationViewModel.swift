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
        @Published var isLoading = false

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
            guard name.count >= Constant.searchQueryMinimum else {
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
            isLoading = true
            networkService.fetchWeatherByCity(withName: name)
                .catch({ [weak self] error -> AnyPublisher<WeatherLocation, Never> in
                    let _ = print("catcherror", error)
                    self?.isLoading = false
                    self?.weatherLocation = nil
                    return Empty(completeImmediately: true).eraseToAnyPublisher()
                })
                .sink(receiveCompletion: { completion in
                    self.isLoading = false
                    switch completion {
                        case .failure(let error): print("Error \(error)")
                        case .finished: print("Publisher is finished")
                    }
                }, receiveValue: { [weak self] value in
                    dump(value)
                    self?.isLoading = false
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
