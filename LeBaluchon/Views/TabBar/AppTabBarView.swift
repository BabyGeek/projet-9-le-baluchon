//
//  CustomTabBarView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//
#if DEBUG

import SwiftUI

struct AppTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    var body: some View {
        TabBar
            .onChange(of: selection) { newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

extension AppTabBarView {
    private func tabView(item: TabBarItem) -> some View {
        VStack {
            Image(systemName: item.iconName)
                .font(.subheadline)
            Text(item.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == item ? item.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == item {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var TabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(item: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    private func switchToTab(tab: TabBarItem) {
            selection = tab
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .weather,
        .exchange,
        .translate
    ]
    
    static var previews: some View {
        VStack {
            Spacer()
            AppTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
        }
    }
}
#endif
