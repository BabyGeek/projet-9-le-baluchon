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
    
    @State private var isLoading = false
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                form
            }
            .navigationTitle("Exchange")
        }
        .onAppear {
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
            Section("Convert a currency") {
                TextField("Amount", value: $amount, format: .currency(code: from))
                    .keyboardType(.decimalPad)
                    .onChange(of: amount) { newValue in
                        viewModel.performFor(from: from, to: to, amount: newValue)
                    }
                
                Picker("From", selection: $from) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("VND").tag("VND")
                }
                .onChange(of: from) { newValue in
                    viewModel.performFor(from: newValue, to: to, amount: amount)
                }
                
                
                Picker("To", selection: $to) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("VND").tag("VND")
                }
                .onChange(of: to) { newValue in
                    viewModel.performFor(from: from, to: newValue, amount: amount)
                }
            }
            
            Section("Result") {
                if let result = viewModel.result {
                    Text("\(amount.formatted(.currency(code: from))) = \(result.result.formatted(.currency(code: to))) ")
                }
            }
        }
    }
}
