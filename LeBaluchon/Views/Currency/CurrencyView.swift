//
//  CurrencyView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import SwiftUI

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
            viewModel.perform(from: "EUR", to: "USD")
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}

extension CurrencyView {
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
    private func updateResult() {
        viewModel.performFor(from: from, to: to, amount: amount)
    }
}

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
