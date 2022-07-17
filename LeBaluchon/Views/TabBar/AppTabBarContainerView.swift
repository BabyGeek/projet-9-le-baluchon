//
//  TabBarContainerView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import SwiftUI

struct AppTabBarContainerView<Content:View>: View {
    
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = [TabBarItem]()
    
    let content: Content
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            
            AppTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct TabBarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .weather,
        .exchange,
        .translate
    ]
    
    static var previews: some View {
        AppTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
