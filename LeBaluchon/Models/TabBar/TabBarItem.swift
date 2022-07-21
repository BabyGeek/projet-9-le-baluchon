//
//  TabBarItem.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

#if DEBUG
import Foundation
import SwiftUI


enum TabBarItem: Hashable {
    case weather, exchange, translate
    
    var iconName: String {
        switch self {
        case .weather: return "thermometer.sun"
        case .exchange: return "banknote"
        case .translate: return "captions.bubble"
        }
    }
    
    var title: String {
        switch self {
        case .weather: return "Weather"
        case .exchange: return "Exchange"
        case .translate: return "Translate"
        }
    }
    
    var color: Color {
        switch self {
        case .weather: return .red
        case .exchange: return .blue
        case .translate: return .green
        }
    }
}
#endif
