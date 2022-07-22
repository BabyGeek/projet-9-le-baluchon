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
    @State var source: String = "en"
    @State var target: String = "fr"
    @State var text: String = "Hello my name is Paul, I am happy to see you here"
    
    @State var selectTarget = false
    
    var body: some View {
        NavigationView {
            form
                .navigationTitle("Translation")
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            self.viewModel.autoloadSource.toggle()
                        }, label: {
                            Image(systemName: self.viewModel.autoloadSource ? "star.bubble.fill" : "star.bubble")
                        })
                    }
                }
        }
        .sheet(isPresented: $selectTarget) {
            SelectTargetSheet(target: target, viewModel: self.viewModel, text: text)
        }
        .onAppear {
            //
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
                    
                    Picker("Source language", selection: $source) {
                        
                        ForEach($viewModel.langs.indices, id: \.self) { index in
                            let lang = viewModel.langs[index]
                            langListView(lang: lang)
                        }
                    }
                }
            }
            
            
            Section("Translate") {
                TextEditor(text: $text)
                    .frame(minHeight: 60, alignment: .leading)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    
                
                Button("Translate") {
                    self.selectTarget = true
                }
            }
            
            Section("Translation") {
                if let results = viewModel.results {
                    Text(results.first!.translatedText)
                }else if viewModel.isLoading {
                    Text("Loading...")
                }else {
                    Text("Nothing to translate yet")
                }
            }
        }
    }
}

struct SelectTargetSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var target: String
    @StateObject var viewModel: TranslationViewModel
    var text: String
    
    var body: some View {
        
        NavigationView {
            Form {
                Picker("Select a target language", selection: $target) {
                    ForEach($viewModel.langs.indices, id: \.self) { index in
                        let lang = viewModel.langs[index]
                        langListView(lang: lang)
                            .id(lang.language)
                    }
                }
                .pickerStyle(.wheel)
                
                Button("Translate") {
                    self.viewModel.target = target
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
                    })
                }
            }
        }
        
    }
    
    func targetSelected(lang: TranslationLanguage) {
        
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
