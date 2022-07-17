//
//  TabBarItem.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case weather, exchange, translate
    
    var iconName: String {
        switch self {
        case .weather: return "house"
        case .exchange: return "heart"
        case .translate: return "person"
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
