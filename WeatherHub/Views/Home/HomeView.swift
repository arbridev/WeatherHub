//
//  HomeView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct HomeView: View {

    @State private var isSelectingMore: Bool = false
    @State private var isPresentingAdd: Bool = false

    var weatherLocations: [WeatherLocation]

    var body: some View {
        NavigationView {
            VStack {
                Text("Weather Hub")
                    .font(.title)
                    .padding(.top, 100)
                    .padding(.bottom, 24)

                List(
                    weatherLocations,
                    id: \.self
                ) { weatherLocation in
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

                Spacer()
            }
            .toolbar {
                Button("More") {
                    isSelectingMore = true
                }
            }
            .confirmationDialog("More", isPresented: $isSelectingMore) {
                Button("Add a location") {
                    isPresentingAdd = true
                }
            }
            .sheet(isPresented: $isPresentingAdd) {
                AddLocationView()
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockResponse.weatherByCityResponseBar
        let previewWeatherLocationGua = MockResponse.weatherByCityResponseGua
        let previewWeatherLocations = [
            previewWeatherLocation,
            previewWeatherLocationGua
        ]
        HomeView(weatherLocations: previewWeatherLocations)
    }
}
