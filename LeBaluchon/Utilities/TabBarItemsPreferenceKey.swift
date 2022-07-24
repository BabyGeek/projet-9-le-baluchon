//
//  TabBarItemsPreferenceKey.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

#if DEBUG
import Foundation
import SwiftUI

/// Tab Bar preference key to allow to handle the tabs selections
struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = [TabBarItem]()

    /// Allow to add multiple values to the tab bar
    /// - Parameters:
    ///   - value: current value
    ///   - nextValue: next value
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

/// View used with the .tabBarItem modifier
struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem

    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    /// .tabBarItem modifier for View objects,
    /// allows you to register the tab and selection corresponding to the View attached
    /// - Parameters:
    ///   - tab: tab corresponding to the tab bar item
    ///   - selection: current tab selected
    /// - Returns: View modifier TabBarItemViewModifier
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
#endif
