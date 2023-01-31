//
//  AddLocationView.swift
//  WeatherHub
//
//  Created by Armando Brito on 15/1/23.
//

import SwiftUI

struct AddLocationView: View {

    @EnvironmentObject var mainData: AppData
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ViewModel()
    @State private var searchQuery: String = ""
    @FocusState private var searchFieldIsFocused: Bool

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.Custom.Button.primary)
                }

                Spacer()
            }
            .padding(.bottom, 12)

            HStack {
                TextField("Search city", text: $searchQuery)
                    .focused($searchFieldIsFocused)
                    .onChange(of: searchQuery, perform: { newValue in
                        viewModel.fetchWeatherLocation(withName: searchQuery)
                    })
                    .tint(Color.Custom.Font.announcement)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.Custom.Background.inter, lineWidth: 2)
            )
            .padding(.top, 12)

            Spacer()

            if viewModel.isLoading {
                NoResultView(isLoading: $viewModel.isLoading, title: nil, suggestion: nil)
            } else {
                if searchQuery.count <= Constant.searchQueryMinimum {
                    NoResultView(
                        isLoading: $viewModel.isLoading,
                        title: "Search for a city",
                        suggestion: "Type the name of the city in the field above"
                    )
                } else if let searchResult = viewModel.weatherLocation {
                    LocationDescriptionView(weatherLocation: searchResult)
                } else {
                    NoResultView(
                        isLoading: $viewModel.isLoading,
                        title: "No city was found",
                        suggestion: nil
                    )
                }
            }

            Spacer()

            Button {
                viewModel.addLocation()
                dismiss()
            } label: {
                Text("Add this new location")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.Custom.Font.darkContrast)
                    .padding()
            }
            .disabled(viewModel.weatherLocation == nil)
            .background(viewModel.weatherLocation != nil ?
                        Color.Custom.Button.primary :
                            Color.Custom.Button.secondary)
            .clipShape(Capsule())
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
        let mainData = AppData()
        mainData.weatherLocations = [MockResponse.weatherByCityResponseGua]
        return AddLocationView()
            .environmentObject(mainData)
    }
}
