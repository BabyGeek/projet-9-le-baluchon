//
//  WeatherRowView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 14/07/2022.
//

import SwiftUI

/// Weather single row view
struct WeatherRowView: View {
    let weather: Weather

    var body: some View {

        HStack(alignment: .center, spacing: 5) {
            weather.weather.first!.symbol
                .font(.system(size: 32))

            Spacer()

            VStack(alignment: .center, spacing: 5) {
                Text(weather.name)
                    .font(.title3)

                MainContent(weather: weather.main)
            }

            Spacer()
            Divider()

            Text(weather.weather.first!.description)
                .font(.footnote)
                .frame(maxWidth: 60)
        }
    }
}

/// Main content view
struct MainContent: View {
    let weather: WeatherMain

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("\(weather.getTemp())")
            HStack(alignment: .center, spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "thermometer.sun.fill")
                    Text("\(weather.getTemp(type: .tempMax))")
                        .font(.caption2)
                }

                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "thermometer.snowflake")
                    Text("\(weather.getTemp(type: .tempMin))")
                        .font(.caption2)
                }
            }
        }
    }
}
