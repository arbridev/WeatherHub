//
//  NoResultView.swift
//  WeatherHub
//
//  Created by Armando Brito on 31/1/23.
//

import SwiftUI

struct NoResultView: View {

    @Binding var isLoading: Bool

    private var title: String?
    private var suggestion: String?

    init(isLoading: Binding<Bool>, title: String?, suggestion: String?) {
        self._isLoading = isLoading
        self.title = title
        self.suggestion = suggestion
    }

    var body: some View {
        VStack {
            Spacer()

            if let title {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.Custom.Font.announcement)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
            }

            if isLoading {
                ProgressView()
                    .padding()
            }

            if let suggestion {
                Text(suggestion)
                    .font(.title3)
                    .foregroundColor(Color.Custom.Font.lightContrast)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            Spacer()
        }
    }
}

struct NoResultView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultView(
            isLoading: .constant(true),
            title: "Title",
            suggestion: "Suggestion, Suggestion, Suggestion, Suggestion"
        )
    }
}
