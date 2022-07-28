//
//  EnvironmentValuesExtensions.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 24/07/2022.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
extension EnvironmentValues {
    var dismiss: () -> Void {
        { presentationMode.wrappedValue.dismiss() }
    }
}
