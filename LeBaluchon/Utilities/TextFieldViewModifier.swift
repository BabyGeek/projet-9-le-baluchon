//
//  TextFieldViewModifier.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 22/07/2022.
//

import Foundation
import SwiftUI

#if DEBUG
/// Add a clear button when entered text is not empty
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

/// Add a placeholder to the text field when the text is empty
struct TextFieldPlacehorlder: ViewModifier {
    @Binding var text: String
    @State var placeholder: String

    func body(content: Content) -> some View {
        ZStack {
            if text.isEmpty {
                TextEditor(text: $placeholder)
                    .font(.body)
                    .foregroundColor(.gray)
                    .disabled(true)
            }

            content
        }
    }
}
#endif
