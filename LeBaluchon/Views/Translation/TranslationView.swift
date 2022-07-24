//
//  TranslationView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 21/07/2022.
//

#if DEBUG
import SwiftUI

struct TranslationView: View {
    @StateObject private var viewModel = TranslationViewModel()
    @State var text: String = ""
    @State var placeholderText: String = "Enter some text to translate"
    
    @State var selectTarget = false
    
    var body: some View {
        NavigationView {
            form
        }
        .sheet(isPresented: $selectTarget) {
            SelectTargetSheet(viewModel: self.viewModel, text: text)
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
                Section("Source") {
                    Picker("Source language", selection: $viewModel.source) {
                        ForEach(viewModel.langs.indices, id: \.self) { index in
                            let lang = viewModel.langs[index]
                            langListView(lang: lang)
                        }
                    }
                }
            }
            
            
            Section("Translate") {
                TextEditor(text: $text)
                    .frame(minHeight: 100, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .modifier(TextFieldClearButton(text: $text))
                    .modifier(TextFieldPlacehorlder(text: $text, placeholder: placeholderText))
                
            }
            
            Section("Actions") {
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
            
            Section("Translation") {
                if let results = viewModel.results {
                    Text(results.getText())
                }else if viewModel.isLoading {
                    Text("Loading...")
                }else {
                    Text("Nothing to translate yet")
                }
            }
        }
        .navigationTitle("Translation")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                Button {
                    self.viewModel.switchLanguage()
                    self.viewModel.autoloadSource = false
                } label: {
                    Image(systemName: "arrow.left.arrow.right.square")
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        self.viewModel.autoloadSource.toggle()
                    }
                } label: {
                    Image(systemName: self.viewModel.autoloadSource ? "star.bubble.fill" : "star.bubble")
                }
            }
        }
    }
}

struct SelectTargetSheet: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: TranslationViewModel
    var text: String
    
    var body: some View {
        
        NavigationView {
            Form {
                Picker("Select a target language", selection: $viewModel.target) {
                    ForEach(viewModel.langs.indices, id: \.self) { index in
                        let lang = viewModel.langs[index]
                        langListView(lang: lang)
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
struct langListView: View {
    let lang: TranslationLanguage
    
    var body: some View {
        Text("\(lang.name) - \(lang.language.uppercased())")
            .tag(lang.language)
    }
}

#endif
