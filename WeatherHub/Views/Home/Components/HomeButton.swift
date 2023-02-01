//
//  HomeButton.swift
//  WeatherHub
//
//  Created by Armando Brito on 1/2/23.
//

import SwiftUI

struct HomeButton: View {
    var action: (() -> Void)
    var label: Text

    var body: some View {
        Button {
            action()
        } label: {
            label
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.Custom.secondary)
                .padding()
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
        .background(Color.Custom.Background.dark)
        .clipShape(Capsule())
        .foregroundColor(Color.Custom.secondary)
        .padding(.horizontal, 48)
        .padding(.top, 24)
    }
}
