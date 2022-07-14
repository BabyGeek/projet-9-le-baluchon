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
                                        
                    
                    VStack(alignment: .center, spacing: 8) {
                        Text("\(weather.main.temp.formatted())°C")
                        HStack(alignment: .center, spacing: 8) {
                            HStack(alignment: .center, spacing: 8) {
                                Image(systemName: "thermometer.sun.fill")
                                Text("\(Int(weather.main.tempMax.rounded()))°C")
                                    .font(.caption2)
                            }
                            
                            HStack(alignment: .center, spacing: 8) {
                                Image(systemName: "thermometer.snowflake")
                                Text("\(Int(weather.main.tempMin.rounded()))°C")
                                    .font(.caption2)
                            }
                        }
                    }
                    
                }
                
                Spacer()
                Divider()
                
                Text(weather.weather.first!.description)
                    .font(.caption)
                    .frame(maxWidth: 50)
            }
    }
}
