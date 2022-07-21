//
//  TabBarView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 16/07/2022.
//
#if DEBUG

import SwiftUI

struct TabBarView: View {
    @State private var selection: String = "weather"
    @State private var selectedTab: TabBarItem = .weather
    
    var body: some View {
        AppTabBarContainerView(selection: $selectedTab) {
            WeatherView()
                .tabBarItem(tab: .weather, selection: $selectedTab)
            
            CurrencyView()
                .tabBarItem(tab: .exchange, selection: $selectedTab)
            
            Color.green
                .tabBarItem(tab: .translate, selection: $selectedTab)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {    
    static var previews: some View {
        TabBarView()
    }
}
#endif
