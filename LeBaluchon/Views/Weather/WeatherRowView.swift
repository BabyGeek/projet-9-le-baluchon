//
//  WeatherRowView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 14/07/2022.
//

import SwiftUI

struct WeatherRowView: View {
    let weather: Weather
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 8) {
            weather.weather.first!.symbol
                .font(.system(size: 44))
            
            Spacer()
            
            VStack(alignment: .center, spacing: 8) {
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

struct MainContent: View {
    let weather: WeatherMain
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("\(weather.temp.formatted())°C")
            HStack(alignment: .center, spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "thermometer.sun.fill")
                    Text("\(Int(weather.tempMax.rounded()))°C")
                        .font(.caption2)
                }
                
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "thermometer.snowflake")
                    Text("\(Int(weather.tempMin.rounded()))°C")
                        .font(.caption2)
                }
            }
        }
    }
}
