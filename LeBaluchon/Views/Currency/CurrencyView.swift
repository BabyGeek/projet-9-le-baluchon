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
    @State var from: String = "EUR"
    @State var to: String = "USD"
    @State var amount: Double = 1
    
    var body: some View {
        NavigationView {
            form
                .navigationTitle("Exchange")
        }
        .onAppear {
            viewModel.performSymbols()
            viewModel.perform(from: "EUR", to: "USD", amount: 1)
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
                let tempFrom = from
                from = to
                to = tempFrom
            }
            
            Section("Convert a currency") {
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                
                Picker("From", selection: $from) {
                    
                    ForEach($viewModel.symbols.indices, id: \.self) { index in
                        let symbol = viewModel.symbols[index]
                        symbolListView(symbol: symbol)
                    }
                }
                
                Picker("To", selection: $to) {
                    ForEach($viewModel.symbols.indices, id: \.self) { index in
                        let symbol = viewModel.symbols[index]
                        symbolListView(symbol: symbol)
                    }
                }
                
            }
            
            Button("Update result") {
                self.updateResult()
            }
            
            
            
            if let result = viewModel.result {
                Section("Result") {
                    Text("\(amount.formatted(.currency(code: from))) = \(result.result.formatted(.currency(code: to))) ")
                }
            }
        }
    }
}


extension CurrencyView {
    /// Call viewModel to update the result displayed
    private func updateResult() {
        viewModel.perform(from: from, to: to, amount: amount)
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
