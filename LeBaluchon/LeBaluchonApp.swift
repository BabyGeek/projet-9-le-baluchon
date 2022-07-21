//
//  LeBaluchonApp.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import SwiftUI

@main
/// Main app launch
struct LeBaluchonApp: App {
    var body: some Scene {
        WindowGroup {
            #if DEBUG
            TabBarView()
            #endif
        }
    }
}
