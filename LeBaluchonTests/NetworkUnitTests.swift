//
//  NetworkUnitTests.swift
//  LeBaluchonTests
//
//  Created by Paul Oggero on 21/07/2022.
//

@testable import LeBaluchon
import XCTest

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
    
    func testGivenErrorFailureThenCompareGetterwithStringsShouldBeEquals() {
        let error = NetworkError.failure
        
        XCTAssertEqual(error.failureReason, NetworkError.failure.failureReason)
        XCTAssertEqual(error.errorDescription, NetworkError.failure.errorDescription)
        XCTAssertEqual(error.recoverySuggestion, NetworkError.failure.recoverySuggestion)
    }
    
    func testGivenErrorThenCreateAppErrorShouldReturnIdentifiableUUIDObject() {
        let appError = AppError(error: NetworkError.unknown)
        
        XCTAssertNotNil(appError.id)
    }
}
