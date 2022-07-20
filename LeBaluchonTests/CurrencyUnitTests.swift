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
    
    func testGivenWeatherWhenFetchingSymbolWhereCodeEURThenSymbolShouldBe€() throws {
        let url = Bundle.main.url(forResource: "symbols", withExtension: "json")!
        let expectation = XCTestExpectation()
        
        viewModel.loadData(urlRequest: url) { (dictionnary: CurrencyDictionnary) in
            let symbol = dictionnary.currencies.first { symbol in
                symbol.code == "EUR"
            }

            XCTAssertEqual(symbol!.getSymbol(), NSLocale(localeIdentifier: "EUR").displayName(forKey: .currencySymbol, value: "EUR"))
            expectation.fulfill()
        } onFailure: { error in
            //
        }
        wait(for: [expectation], timeout: 3)
    }
}
