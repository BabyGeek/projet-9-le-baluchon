//
//  CurrencyUnitTests.swift
//  LeBaluchonTests
//
//  Created by Paul Oggero on 19/07/2022.
//

@testable import LeBaluchon
import XCTest

class CurrencyUnitTests: XCTestCase {
    var viewModel: CurrencyViewModel!
    

    @MainActor override func setUp() {
        super.setUp()
        viewModel = CurrencyViewModel()
    }

    func testGivenNewWhenCheckingShouldBeNilOrEmpty() throws {
        XCTAssertNil(viewModel.result)
        XCTAssertTrue(viewModel.symbols.isEmpty)
    }
    
    func testGivenWeatherWhenFetchingRateThenModelShouldBeBeFrom1EURToVND() throws {
        let url = Bundle.main.url(forResource: "rate", withExtension: "json")!

        viewModel.loadData(urlRequest: url) { (result: ExchangeRateResult) in
            XCTAssertEqual(result.from, "EUR")
            XCTAssertEqual(result.to, "VND")
            XCTAssertEqual(result.result, 23661.5627)
        } onFailure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenWeatherWhenFetchingRateThenModelShouldBeBeFrom3EURToVND() throws {
        let url = Bundle.main.url(forResource: "exchange", withExtension: "json")!

        viewModel.loadData(urlRequest: url) { (result: ExchangeRateResult) in
            XCTAssertEqual(result.from, "EUR")
            XCTAssertEqual(result.to, "VND")
            XCTAssertEqual(result.rate, 23661.5627)
            XCTAssertEqual(result.result, 70984.6881)
        } onFailure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenWeatherWhenFetchingSymbolsThenModelShouldNotBeEmpty() throws {
        let url = Bundle.main.url(forResource: "symbols", withExtension: "json")!

        viewModel.loadData(urlRequest: url) { (dictionnary: CurrencyDictionnary) in
            XCTAssertFalse(dictionnary.currencies.isEmpty)
        } onFailure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenWeatherWhenFetchingSymbolsThenFirstSymbolShouldBeEUR() throws {
        let url = Bundle.main.url(forResource: "symbols", withExtension: "json")!
        viewModel.loadData(urlRequest: url) { (dictionnary: CurrencyDictionnary) in
            let symbol = dictionnary.currencies.first { symbol in
                symbol.code == "EUR"
            }
            XCTAssertEqual(symbol?.getSymbol(), NSLocale(localeIdentifier: "EUR").displayName(forKey: .currencySymbol, value: "EUR"))
        } onFailure: { error in
            XCTAssertNil(error)
        }
    }
}
