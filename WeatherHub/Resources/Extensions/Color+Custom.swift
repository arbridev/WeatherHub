//
//  Color+Custom.swift
//  WeatherHub
//
//  Created by Armando Brito on 31/1/23.
//

import SwiftUI

extension Color {

    struct Custom {
        private init() {}

        private static let paletteYellow = Color(UIColor(hex: "#FFB53B")!)
        private static let paletteRed = Color(UIColor(hex: "#DB2917")!)
        private static let palettePurple = Color(UIColor(hex: "#C24FF0")!)
        private static let paletteLightBlue = Color(UIColor(hex: "#2ac6fa")!)
        private static let paletteBlue = Color(UIColor(hex: "#4570D9")!)
        private static let paletteDarkBlue = Color(UIColor(hex: "#1f3366")!)
        private static let paletteGreen = Color(UIColor(hex: "#52FFCD")!)

        private static let paletteWhite = Color(UIColor(hex: "#f0f2f5")!)
        private static let paletteGray = Color(UIColor(hex: "#dadce0")!)
        private static let paletteDarkGray = Color(UIColor(hex: "#5f6369")!)
        private static let paletteBlack = Color(UIColor(hex: "#292b2e")!)

        static let primary = paletteBlue
        static let secondary = paletteYellow
        static let tertiary = palettePurple

        struct Background {
            private init() {}
            static let light: Color = paletteWhite
            static let lightBlue: Color = paletteLightBlue
            static let dark: Color = paletteDarkBlue
            static let inter: Color = paletteGray
        }

        struct Font {
            private init() {}
            static let lightContrast: Color = paletteBlack
            static let darkContrast: Color = paletteWhite
            static let announcement: Color = paletteDarkBlue
        }

        struct Button {
            private init() {}
            static let primary: Color = paletteDarkBlue
            static let secondary: Color = paletteGray
            static let primaryDark: Color = paletteDarkBlue
        }

        struct Weather {
            private init() {}
            static let clear: Color = paletteLightBlue
            static let clouds: Color = paletteLightBlue
            static let rain: Color = paletteDarkGray
            static let snow: Color = paletteDarkGray
            static let extreme: Color = paletteDarkGray
            static let unknown: Color = paletteDarkGray
        }

        struct WeatherIcon {
            private init() {}
            static let clear: Color = paletteYellow
            static let clouds: Color = paletteWhite
            static let rain: Color = paletteGray
            static let snow: Color = paletteWhite
            static let extreme: Color = paletteBlue
            static let unknown: Color = paletteWhite
        }
    }

}
