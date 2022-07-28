//
//  TranslationView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 21/07/2022.
//

import SwiftUI

struct TranslationView: View {
    @StateObject private var viewModel = TranslationViewModel()
    @State var text: String = ""
    @State var placeholderText: String = "Enter some text to translate"

    @State var selectTarget = false

    var body: some View {
        NavigationView {
            form
                .navigationTitle("Translation")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {

                        Button {
                            self.viewModel.switchLanguage()
                            self.viewModel.autoloadSource = false
                        } label: {
                            Image(systemName: "arrow.left.arrow.right.square")
                        }

                        Button {
                            withAnimation {
                                self.viewModel.autoloadSource.toggle()
                            }
                        } label: {
                            if #available(iOS 15, *) {
                                Image(systemName: self.viewModel.autoloadSource ? "star.bubble.fill" : "star.bubble")
                            } else {
                                Image(systemName: self.viewModel.autoloadSource ? "star.fill" : "star")
                            }
                        }
                    }
                }
        }
        .sheet(isPresented: $selectTarget) {
            SelectTargetSheetView(text: text)
                .environmentObject(viewModel)
        }
        .alert(item: $viewModel.error) { error in
            guard let descrition = error.error.errorDescription, let message = error.error.failureReason else {
                return Alert(
                    title: Text(NetworkError.unknown.errorDescription!),
                    message: Text(NetworkError.unknown.failureReason!))
            }

            return Alert(
                title: Text(descrition),
                message: Text(message))
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
    }
}

extension TranslationView {
    private var form: some View {
        Form {
            if !self.viewModel.autoloadSource {
                Section(header: Text("Source")) {
                    Picker("Source language", selection: $viewModel.source) {
                        ForEach(viewModel.langs.indices, id: \.self) { index in
                            let lang = viewModel.langs[index]
                            LangListView(lang: lang)
                        }
                    }
                }
            }

            Section(header: Text("Translate")) {
                TextEditor(text: $text)
                    .frame(minHeight: 100, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .modifier(TextFieldClearButton(text: $text))
                    .modifier(TextFieldPlacehorlder(text: $text, placeholder: placeholderText))

            }

            Section(header: Text("Actions")) {
                Button {
                    self.selectTarget = true
                } label: {
                    Text("Translate")
                }

                Button {
                    self.viewModel.performForText(text)
                } label: {
                    Text("Direct translate in \(viewModel.getTargetLabel())")
                }
            }

            Section(header: Text("Translation")) {
                if let results = viewModel.results {
                    Text(results.getText())
                } else if viewModel.isLoading {
                    Text("Loading...")
                } else {
                    Text("Nothing to translate yet")
                }
            }
        }
    }
}
