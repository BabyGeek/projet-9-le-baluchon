//
//  TabBarView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 16/07/2022.
//
#if DEBUG

import SwiftUI

/// Tab Bar base view
struct TabBarView: View {
    @State private var selection: String = "weather"
    @State private var selectedTab: TabBarItem = .weather

    var body: some View {
        AppTabBarContainerView(selection: $selectedTab) {
            WeatherView()
                .tabBarItem(tab: .weather, selection: $selectedTab)
                .phoneOnlyNavigationView()

            CurrencyView()
                .tabBarItem(tab: .exchange, selection: $selectedTab)
                .phoneOnlyNavigationView()

            TranslationView()
                .tabBarItem(tab: .translate, selection: $selectedTab)
                .phoneOnlyNavigationView()
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
#endif
