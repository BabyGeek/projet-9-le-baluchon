//
//  TextFieldViewModifier.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 22/07/2022.
//

import Foundation
import SwiftUI

#if DEBUG
struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
                    .onTapGesture {
                        self.text = ""
                    }
            }
        }
    }
}
#endif
