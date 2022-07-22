//
//  TranslationUnitTests.swift
//  LeBaluchonTests
//
//  Created by Paul Oggero on 22/07/2022.
//

@testable import LeBaluchon
import XCTest

class TranslationUnitTests: XCTestCase {

    var viewModel: TranslationViewModel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = TranslationViewModel()
    }

    func testGivenNewWhenCheckingShouldBeNilOrEmptyExceptSourceTargetAndLangs() throws {
        XCTAssertNil(viewModel.results)
        XCTAssertNil(viewModel.error)
        
        XCTAssertFalse(viewModel.isLoading)

        XCTAssertNotNil(viewModel.langs)
        XCTAssertTrue(viewModel.autoloadSource)

        XCTAssertEqual(viewModel.source, "en")
        XCTAssertEqual(viewModel.target, "vi")
        XCTAssertEqual(viewModel.getSourceLabel(), "")
        XCTAssertEqual(viewModel.getTargetLabel(), "")
    }

    func testGivenNoneWhenFetchingLanguagesThenFirstLanguageShouldBebhAndDictionnary() throws {
        let url = Bundle.main.url(forResource: "langs", withExtension: "json")!
        let expectation = XCTestExpectation()

        viewModel.loadData(urlRequest: url) { (languageDictionnary: TranslationLanguageData) in
            let first = languageDictionnary.data.languages.first!
            XCTAssertEqual(first.language, "bh")
            expectation.fulfill()
        } onFailure: { error in
            //
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGivenNoneWhenFetchingLanguagesThenDirectoryShouldFindEnglishForen() throws {
        let url = Bundle.main.url(forResource: "langs", withExtension: "json")!
        let expectation = XCTestExpectation()

        viewModel.loadData(urlRequest: url) { (languageDictionnary: TranslationLanguageData) in
            let dictionnary = languageDictionnary.data
            XCTAssertEqual(dictionnary.getNameForLanguage("en"), "English")
            expectation.fulfill()
        } onFailure: { error in
            //
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGivenNoneWhenFetchingTranslateThenResponseTextShouldBeBonjour() throws {
        let url = Bundle.main.url(forResource: "translate", withExtension: "json")!
        let expectation = XCTestExpectation()

        viewModel.loadData(urlRequest: url) { (translationData: TranslationData) in
            let text = translationData.data.getText()
            XCTAssertEqual(text, "Bonjour")
            expectation.fulfill()
        } onFailure: { error in
            //
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGivenSourceENAndTargetVIWhenSwitchLanguagesThenLanguagesShouldHaveInvert() throws {
        XCTAssertEqual(viewModel.source, "en")
        XCTAssertEqual(viewModel.target, "vi")
        
        viewModel.switchLanguage()
        
        XCTAssertEqual(viewModel.source, "vi")
        XCTAssertEqual(viewModel.target, "en")
        
    }
    
    
}
