//
//  CurrencyView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import SwiftUI

/// View for the currency page
struct CurrencyView: View {
    @StateObject private var viewModel = CurrencyViewModel()

    var body: some View {
        NavigationView {
            form
                .navigationTitle("Exchange")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.viewModel.switchCurrencies()
                        } label: {
                            Image(systemName: "arrow.left.arrow.right.square")
                        }
                    }
                }
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
            Section(header: Text("Convert a currency")) {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.decimalPad)

                Picker("From", selection: $viewModel.source) {
                    ForEach(viewModel.symbols, id: \.self) { symbol in
                        SymbolListView(symbol: symbol)
                    }
                }

                Picker("To", selection: $viewModel.target) {
                    ForEach(viewModel.symbols, id: \.self) { symbol in
                        SymbolListView(symbol: symbol)
                    }
                }
            }

            Button("Update result") {
                self.updateResult()
            }

            Section(header: Text("Result")) {
                if viewModel.isLoading {
                    Text("Loading...")
                } else {
                    Text(viewModel.result != nil ?
                         "\(viewModel.getLocaleStringFor()) = \(viewModel.getLocaleStringFor(.target))"
                         : "No exchange done yet.")
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
struct SymbolListView: View {
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
