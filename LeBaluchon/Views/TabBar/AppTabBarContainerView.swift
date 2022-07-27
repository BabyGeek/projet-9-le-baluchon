//
//  TabBarContainerView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

#if DEBUG
import SwiftUI

/// Tab bar container, contains the views, the tab bar items, and make all in the same ZStack
struct AppTabBarContainerView<Content: View>: View {

    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = [TabBarItem]()
    @State private var keyboardEnabled: Bool = false

    let content: Content

    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
                .endTextEditing(including: keyboardEnabled ? .all : .subviews)

            if !self.keyboardEnabled {
                AppTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
            }
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            print("keyboardUP")
            self.keyboardEnabled = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation(.easeInOut(duration: 0.7)) {
                self.keyboardEnabled = false
            }
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
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#endif
