//
//  HomeView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct HomeView: View {

    private let background = Color.Custom.primary

    @EnvironmentObject var mainData: AppData
    @StateObject private var viewModel: ViewModel = ViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Weather Hub")
                    .font(.system(size: 44))
                    .fontWeight(.thin)
                    .foregroundColor(Color.Custom.Font.darkContrast)
                    .padding(.top, 100)
                    .padding(.bottom, 24)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    if mainData.weatherLocations.count > 0 {
                        List {
                            ForEach(mainData.weatherLocations, id: \.self) { weatherLocation in
                                NavigationLink {
                                    DetailView(weatherLocation: weatherLocation)
                                } label: {
                                    LocationWeatherRowView(weatherLocation: weatherLocation)
                                }
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .foregroundColor(
                                            backgroundColor(
                                                forWeatherStatus: WeatherStatus(
                                                    rawValue: weatherLocation.weather?.first?.main ?? ""
                                                )
                                            )
                                        )
                                        .padding(.bottom, 16)
                                )
                                .listRowSeparator(.hidden)
                                .padding(.bottom, 16)
                            }
                            .onDelete(perform: deleteLocations(fromIndexSet:))
                        }
                        .scrollContentBackground(.hidden)

                        HomeButton(action: {
                            viewModel.fetchWeatherLocations()
                        }, label: Text("Update weather"))
                    } else {
                        HomeButton(action: {
                            viewModel.isPresentingAdd = true
                        }, label: Text("Add a location"))
                    }
                }

                Spacer()
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
            .background(background)
            .toolbar {
                Button("More") {
                    viewModel.isSelectingMore = true
                }
            }
            .confirmationDialog("More", isPresented: $viewModel.isSelectingMore) {
                Button("Add a location") {
                    viewModel.isPresentingAdd = true
                }
            }
            .sheet(isPresented: $viewModel.isPresentingAdd) {
                AddLocationView()
            }
            .onAppear {
                viewModel.mainData = mainData
                viewModel.fetchWeatherLocations()
            }
        }
        .tint(Color.Custom.secondary)
    }

    func deleteLocations(fromIndexSet indexSet: IndexSet?) {
        guard let indices = indexSet else {
            return
        }
        viewModel.removeWeatherLocations(fromIndices: indices)
    }

    func backgroundColor(forWeatherStatus status: WeatherStatus?) -> Color {
        guard let status else {
            return Color.Custom.Weather.unknown
        }

        switch status {
            case .clear:
                return Color.Custom.Weather.clear
            case .clouds:
                return Color.Custom.Weather.clouds
            case .rain:
                return Color.Custom.Weather.rain
            case .snow:
                return Color.Custom.Weather.snow
            case .extreme:
                return Color.Custom.Weather.extreme
            default:
                return Color.Custom.Weather.unknown
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let mainData = AppData()
        mainData.weatherLocations = [
            MockResponse.weatherByCityResponseBar,
            MockResponse.weatherByCityResponseGua,
            MockResponse.weatherByCityResponseBaires
        ]
        return HomeView()
            .environmentObject(mainData)
    }
}
