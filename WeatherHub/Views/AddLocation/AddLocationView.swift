//
//  AddLocationView.swift
//  WeatherHub
//
//  Created by Armando Brito on 15/1/23.
//

import SwiftUI

struct AddLocationView: View {

    @EnvironmentObject var mainData: AppData
    @State private var searchQuery: String = ""
    @StateObject private var viewModel = ViewModel()
    @FocusState private var searchFieldIsFocused: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                }

                Spacer()
            }

            TextField("Search", text: $searchQuery)
                .focused($searchFieldIsFocused)
                .onChange(of: searchQuery, perform: { newValue in
                    viewModel.fetchWeatherLocation(withName: searchQuery)
                })
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding(.top, 24)

            Spacer()

            if let searchResult = viewModel.weatherLocation {
                LocationDescriptionView(weatherLocation: searchResult)
            } else {
                EmptyView()
            }

            Spacer()

            Button {
                viewModel.addLocation()
                dismiss()
            } label: {
                Text("Add this new location")
            }
            .padding(.bottom, 16)
        }
        .padding()
        .onAppear {
            viewModel.mainData = mainData
            searchFieldIsFocused = true
        }
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
    }
}
