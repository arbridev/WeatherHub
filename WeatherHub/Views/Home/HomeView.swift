//
//  HomeView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var mainData: AppData
    @StateObject private var viewModel: ViewModel = ViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Weather Hub")
                    .font(.title)
                    .padding(.top, 100)
                    .padding(.bottom, 24)

                List {
                    ForEach(mainData.weatherLocations, id: \.self) { weatherLocation in
                        NavigationLink {
                            DetailView(weatherLocation: weatherLocation)
                        } label: {
                            LocationWeatherRowView(weatherLocation: weatherLocation)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 20.0)
                                .foregroundColor(.white)
                                .padding(.bottom, 16)
                        )
                        .listRowSeparator(.hidden)
                        .padding(.bottom, 16)
                    }
                    .onDelete(perform: deleteLocations(fromIndexSet:))
                }

                Spacer()
            }
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
    }

    func deleteLocations(fromIndexSet indexSet: IndexSet?) {
        guard let indices = indexSet else {
            return
        }
        viewModel.removeWeatherLocations(fromIndices: indices)
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
