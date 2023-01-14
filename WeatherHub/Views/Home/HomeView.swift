//
//  HomeView.swift
//  WeatherHub
//
//  Created by Armando Brito on 14/1/23.
//

import SwiftUI

struct HomeView: View {

    @State private var isSelectingMore: Bool = false

    var weatherLocations: [WeatherByCityResponse]

    var body: some View {
        NavigationView {
            VStack {
                Text("Weather Hub")
                    .font(.title)
                    .padding(.top, 100)
                    .padding(.bottom, 24)

                List {
                    ForEach(weatherLocations, id: \.id) { weatherLocation in
                        LocationWeatherRowView(weatherLocation: weatherLocation)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 16)
                            )
                            .listRowSeparator(.hidden)
                            .padding(.bottom, 16)
                    }
                }

                Spacer()
            }
            .toolbar {
                Button("More") {
                    print("onMore")
                    isSelectingMore = true
                }
            }
            .confirmationDialog("More", isPresented: $isSelectingMore) {
                Button("Add a location") {
                    print("onAddALocation")
                }
                Button("Settings") {
                    print("onSettings")
                }
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWeatherLocation = MockingHelper.weatherByCityResponse
        let previewWeatherLocations = [
            previewWeatherLocation,
            previewWeatherLocation
        ]
        HomeView(weatherLocations: previewWeatherLocations)
    }
}


extension SwiftUI.Font {

}
