//
//  AddLocationView.swift
//  WeatherHub
//
//  Created by Armando Brito on 15/1/23.
//

import SwiftUI

struct AddLocationView: View {

    @State private var searchQuery: String = ""
    @State private var searchResult: WeatherLocation?
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
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding(.top, 24)

            Spacer()

            if let searchResult {
                LocationDescriptionView(weatherLocation: searchResult)
            } else {
                EmptyView()
            }

            Spacer()

            Button {
                print("onAddLocation")
            } label: {
                Text("Add this new location")
            }
            .padding(.bottom, 16)
        }
        .padding()
        .onAppear {
            searchResult = MockResponse.weatherByCityResponseBar
        }
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
    }
}
