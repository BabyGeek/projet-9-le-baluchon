//
//  ViewExtensions.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 23/07/2022.
//

import Foundation
import SwiftUI



extension View {
    /// Add extention to dismiss keyboard display on view click
    func endTextEditing(including: GestureMask = .all) -> some View {
        return self
            .highPriorityGesture(TapGesture().onEnded({ _ in
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil, from: nil, for: nil)
            }), including: including)
    }
}



extension View {
    /// Change the default behavior for landscape style view on iphone
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
