//
//  TabBarView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 16/07/2022.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: String = "weather"
    
    var body: some View {
        TabView(selection: $selection) {
            WeatherView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Weather")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Exhange")
                }
            
            Color.green
                .tabItem {
                    Image(systemName: "person")
                    Text("Translate")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
