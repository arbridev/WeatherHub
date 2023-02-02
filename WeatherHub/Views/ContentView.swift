//
//  ContentView.swift
//  WeatherHub
//
//  Created by Armando Brito on 6/12/22.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var weatherLocations = [WeatherLocation]()
}

struct ContentView: View {

    @StateObject var mainData = AppData()

    var body: some View {
        HomeView()
            .environmentObject(mainData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
