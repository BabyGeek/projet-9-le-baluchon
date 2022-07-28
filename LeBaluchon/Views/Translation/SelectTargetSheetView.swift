//
//  SelectTargetSheetView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 28/07/2022.
//

import SwiftUI


struct SelectTargetSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: TranslationViewModel
    var text: String

    var body: some View {
        NavigationView {
            Form {
                Picker("Select a target language", selection: $viewModel.target) {
                    ForEach(viewModel.langs.indices, id: \.self) { index in
                        let lang = viewModel.langs[index]
                        LangListView(lang: lang)
                            .id(lang.language)
                    }
                }
                .pickerStyle(.wheel)

                Button("Translate") {
                    self.viewModel.performForText(text)
                    self.dismiss()
                }
            }
            .navigationTitle("Target language")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    })
                }
            }
        }
    }
}

/// Lang view for select list
struct LangListView: View {
    let lang: TranslationLanguage

    var body: some View {
        Text("\(lang.name) - \(lang.language.uppercased())")
            .tag(lang.language)
    }
}

struct SelectTargetSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTargetSheetView(text: "Preview")
            .environmentObject(TranslationViewModel())
    }
}
