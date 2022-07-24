//
//  CurrencyView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

#if DEBUG

import SwiftUI

/// View for the currency page
struct CurrencyView: View {
    @StateObject private var viewModel = CurrencyViewModel()
    
    var body: some View {
        NavigationView {
            form
                .navigationTitle("Exchange")
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

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}

extension CurrencyView {
    /// Form view for the currency page
    private var form: some View {
        Form {
            
            Button("Switch currencies") {
                viewModel.switchCurrencies()
            }
            
            Section(header: Text("Convert a currency")) {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.decimalPad)
                
                Picker("From", selection: $viewModel.source) {
                    
                    ForEach($viewModel.symbols.indices, id: \.self) { index in
                        let symbol = viewModel.symbols[index]
                        symbolListView(symbol: symbol)
                    }
                }
                
                Picker("To", selection: $viewModel.target) {
                    ForEach($viewModel.symbols.indices, id: \.self) { index in
                        let symbol = viewModel.symbols[index]
                        symbolListView(symbol: symbol)
                    }
                }
                
            }
            
            Button("Update result") {
                self.updateResult()
            }
            
            if let _ = viewModel.result {
                Section(header: Text("Result")) {
                    Text("\(viewModel.getLocaleStringFor()) = \(viewModel.getLocaleStringFor(.target)) ")
                }
            }
        }
    }
}


extension CurrencyView {
    /// Call viewModel to update the result displayed
    private func updateResult() {
        viewModel.perform()
    }
}

/// Symbol view for select list
struct symbolListView: View {
    let symbol: CurrencySymbol
    
    var body: some View {
        if let symbolCurrency = symbol.getSymbol() {
            Text("\(symbol.code) - \(symbolCurrency)")
                .tag(symbol.code)
        } else {
            Text("\(symbol.code)")
                .tag(symbol.code)
        }
    }
}

#endif
