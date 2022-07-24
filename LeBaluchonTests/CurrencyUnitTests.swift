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
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(viewModel.symbols.isEmpty)
    }
    
    func testGivenWeatherWhenFetchingRateThenModelShouldBeBeFrom1EURToVND() throws {
        let url = Bundle.main.url(forResource: "rate", withExtension: "json")!
        let expectation = XCTestExpectation()

        viewModel.loadData(urlRequest: url) { (result: ExchangeRateResult) in
            XCTAssertEqual(result.from, "EUR")
            XCTAssertEqual(result.to, "VND")
            XCTAssertEqual(result.result, 23661.5627)
            expectation.fulfill()
        } onFailure: { error in
            //
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGivenWeatherWhenFetchingRateThenModelShouldBeBeFrom3EURToVND() throws {
        let url = Bundle.main.url(forResource: "exchange", withExtension: "json")!
        let expectation = XCTestExpectation()
        
        viewModel.loadData(urlRequest: url, onSuccess: { (result: ExchangeRateResult) in
            XCTAssertEqual(result.from, "EUR")
            XCTAssertEqual(result.to, "VND")
            XCTAssertEqual(result.rate, 23661.5627)
            XCTAssertEqual(result.result, 70984.6881)
            expectation.fulfill()
        }, onFailure: { error in
            //
        })
        wait(for: [expectation], timeout: 3)
    }
    
    func testGivenWeatherWhenFetchingSymbolsThenModelShouldNotBeEmpty() throws {
        let url = Bundle.main.url(forResource: "symbols", withExtension: "json")!
        let expectation = XCTestExpectation()

        viewModel.loadData(urlRequest: url) { (dictionnary: CurrencyDictionnary) in
            XCTAssertFalse(dictionnary.currencies.isEmpty)
            expectation.fulfill()
        } onFailure: { error in
            //
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGivenCurrencySymbolEURWhenFetchingSymbolThenSymbolShouldBe€() throws {
        let symbol = CurrencySymbol(code: "EUR", name: "Euro")
        XCTAssertEqual(symbol.getSymbol(), NSLocale(localeIdentifier: "EUR").displayName(forKey: .currencySymbol, value: "EUR"))
    }
    
    func testGivenCurrencySymbolZZZWhenFetchingSymbolThenSymbolShouldBeNil() throws {
        let currencySymbol = CurrencySymbol(code: "ZZZ", name: "ZCoin")
        XCTAssertNil(currencySymbol.getSymbol())
    }
    
    func testGivenSourceEURAndTargetVNDWhenSwitchCurrenciesThenLanguagesShouldHaveInvert() throws {
        XCTAssertEqual(viewModel.source, "EUR")
        XCTAssertEqual(viewModel.target, "VND")
        
        viewModel.switchCurrencies()
        
        XCTAssertEqual(viewModel.source, "VND")
        XCTAssertEqual(viewModel.target, "EUR")
    }
    
    func testGivenNewObjectSourceEURAndTargetVNDWhenGettingLocaleStringThenStringShouldBe1() throws {
        XCTAssertEqual(viewModel.getLocaleStringFor(), "€1,00")
    }
    
    func testGivenNewObjectSourceEURAndTargetVNDWhenGettingLocaleForTargetStringThenStringShouldBeEmpty() throws {
        XCTAssertEqual(viewModel.getLocaleStringFor(.target), "")
    }
}
