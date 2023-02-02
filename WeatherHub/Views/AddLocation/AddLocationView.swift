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

    var addingShouldBeDisabled: Bool {
        return viewModel.weatherLocation == nil || searchQuery.count < Constant.searchQueryMinimum
    }

    var body: some View {
        ZStack {
            Color.Custom.primary
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.Custom.secondary)
                    }

                    Spacer()
                }
                .padding(.bottom, 12)

                HStack {
                    TextField(
                        text: $searchQuery,
                        prompt: Text("Input a city")
                            .foregroundColor(Color.Custom.Font.announcement)
                    ) {

                    }
                    .focused($searchFieldIsFocused)
                    .tint(Color.Custom.Font.darkContrast)
                    .foregroundColor(Color.Custom.Font.darkContrast)
                    .onChange(of: searchQuery, perform: { newValue in
                        viewModel.fetchWeatherLocation(withName: searchQuery)
                    })
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
                    if searchQuery.count < Constant.searchQueryMinimum {
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
                        .foregroundColor(
                            !addingShouldBeDisabled ?
                            Color.Custom.secondary :
                                Color.Custom.Font.darkContrast
                        )
                        .padding()
                }
                .disabled(addingShouldBeDisabled)
                .background(!addingShouldBeDisabled ?
                            Color.Custom.Button.primary :
                                Color.Custom.Button.secondary)
                .clipShape(Capsule())
            }
            .padding()
        }
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
