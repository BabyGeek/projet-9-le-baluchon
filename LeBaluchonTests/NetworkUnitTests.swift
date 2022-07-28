//
//  NetworkUnitTests.swift
//  LeBaluchonTests
//
//  Created by Paul Oggero on 21/07/2022.
//

import XCTest
import SwiftUI

class NetworkUnitTests: XCTestCase {
    var manager: NetworkManager!

    @MainActor override func setUp() {
        super.setUp()
        manager = NetworkManager()
    }

    func testGivenValidURLThenDecodeWithWrongDecoableShouldReturnFailureError() {
        let url = Bundle.main.url(forResource: "symbols", withExtension: "json")!
        let expectation = XCTestExpectation()

        manager.loadData(urlRequest: url) { (_: Weather) in
        } onFailure: { error in
            XCTAssertEqual(error, NetworkError.failure)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func testGivenWrongResponseURLThenFetchingShouldReturnLoadDataError() {
        let expectation = XCTestExpectation()

        manager.loadData(urlRequest: URL(string: "test.fr")!) { (_: Weather) in
        } onFailure: { error in
            XCTAssertEqual(error, NetworkError.loadDataError)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func testGivenErrorFailureThenCompareGetterWithStringsShouldBeEquals() {
        let error = NetworkError.failure

        XCTAssertEqual(error.failureReason, NetworkError.failure.failureReason)
        XCTAssertEqual(error.errorDescription, NetworkError.failure.errorDescription)
        XCTAssertEqual(error.recoverySuggestion, NetworkError.failure.recoverySuggestion)
    }

    func testGivenErrorUnknownThenCompareGetterWithStringsShouldBeEquals() {
        let error = NetworkError.unknown

        XCTAssertEqual(error.failureReason, NetworkError.unknown.failureReason)
        XCTAssertEqual(error.errorDescription, NetworkError.unknown.errorDescription)
        XCTAssertEqual(error.recoverySuggestion, NetworkError.unknown.recoverySuggestion)
    }

    func testGivenErrorWrongURLThenCompareGetterWithStringsShouldBeEquals() {
        let error = NetworkError.wrongURLError

        XCTAssertEqual(error.failureReason, NetworkError.wrongURLError.failureReason)
        XCTAssertEqual(error.errorDescription, NetworkError.wrongURLError.errorDescription)
        XCTAssertEqual(error.recoverySuggestion, NetworkError.wrongURLError.recoverySuggestion)
    }

    func testGivenErrorWrongDataThenCompareGetterWithStringsShouldBeEquals() {
        let error = NetworkError.loadDataError

        XCTAssertEqual(error.failureReason, NetworkError.loadDataError.failureReason)
        XCTAssertEqual(error.errorDescription, NetworkError.loadDataError.errorDescription)
        XCTAssertEqual(error.recoverySuggestion, NetworkError.loadDataError.recoverySuggestion)
    }

    func testGivenErrorThenCreateAppErrorShouldReturnIdentifiableObject() {
        let appError = AppError(error: NetworkError.unknown)

        XCTAssertNotNil(appError.id)
    }
}
